*** This do-file is for replicating the figure 4 in Fang and Qiu (2023). Using CPS data from (i) 1986-2012 , and (ii) 1962-2024. ***

** Preparing the data
clear
cd "E:\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Data"
use cps_00004.dta

* drop irrelevant variables (for all analysis)
drop serial month cpsid asecflag hflag statecensus pernum cpsidp cpsidv asecwth

* drop irrelevant variables (for this exercise)
drop race marst occ ind inctot incbus incfarm inclongj oincbus oincfarm oincwage

* count obs b/w 1986 - 2012
count if year >= 1986 & year <= 2012
* get #obs = 4,723,421. The data in replication packgage has #obs = 4,768,394

* drop those with weight <= 0 (Note: These are valid weights)
drop if asecwt <= 0 // there are about five hundred of these.

* drop those with missing wages or invalid wages
drop if incwage == 99999999 | incwage == 99999998 | incwage == .

* drop those with wage = 0
drop if incwage == 0

* create real wage variable and its log
merge m:1 year using "E:\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Data\CPI_1913_to_2024_cleaned.dta"
keep if _merge == 1 | _merge == 3
drop _merge

gen realwage = incwage/CPI
gen logrealwage = log(realwage)

* Create imputed years of schooling
drop if educ == . | educ == 999  // drop missing or unknown level of educations


gen eduyrs = . // Create the new variable. Using the same logic in the replication packgage.

replace eduyrs = 0 if educ < 10
replace eduyrs = 6 if educ >= 10 & educ <= 32
replace eduyrs = 9 if educ >= 40 & educ <= 60
replace eduyrs = 12 if educ >= 70 & educ <= 81
replace eduyrs = 14 if educ >= 90 & educ <= 100
replace eduyrs = 16 if educ >= 110 & educ <= 122
replace eduyrs = 18 if educ >= 123
replace eduyrs = 20 if educ == 125

* create year-of-birth variable
gen ybirth = year - age

* create experience variable
gen exp_baseline = min(age - eduyrs - 6, age - 18)

* create outlier flag
// Calculate the 2.5th and 97.5th percentile income for each year
gen double income_bottom2_5pct = . 
gen double income_top2_5pct = .

levelsof year, local(years_list) // Stores unique years in a local macro called 'years_list'
foreach y of local years_list {
    display "Processing year: `y'" 
    
    // Calculate 2.5th and 97.5th percentiles for the current year
    _pctile incwage [pweight=asecwt] if year == `y', percentiles(2.5 97.5)
    
    local p2_5 = r(r1)
    local p97_5 = r(r2)
	
	// Display the calculated percentiles
    display "  {txt}2.5th Percentile: {res}`p2_5'"
    display "  {txt}97.5th Percentile: {res}`p97_5'"
    
    // Generate the flags for the current year
    
    replace income_bottom2_5pct = (incwage <= `p2_5') if year == `y'
    

    replace income_top2_5pct = (incwage >= `p97_5') if year == `y'	
}

// Generate the outlier flag
gen outlier = income_bottom2_5pct + income_top2_5pct

* gen exp bins
egen wexp_group = cut(exp_baseline), at(0(5)40) // working life = 40 yrs old. Incrementing from 0 by 5 each step.

* gen cohort bins
egen byear_group = cut(ybirth), at (1870(5)2024) // the min ybirth is 1870

// create dummy variables based on this. (This is only used for relabelling later on)
tab byear_group, g(d_c) // dummies for each cohort bin (g() means generate dummies)
local n_cohort = r(r) // store number of cohort bins

// relabel cohort from 1 to the number of cohort bins (instead of the labelling by the first year of each bin)
gen coh_rlb = .		
foreach num of numlist 1(1)`n_cohort'{ //(use the `n_cohort' list, starting from the first, then incrementing by 1 each time.
	replace coh_rlb = `num' if d_c`num' == 1
}

* gen time dummy (This is only used for relabelling later on and create Deaton's time dummy)
tab year, g(d_t) // dummies for each year
local n_year = r(r)	

// relabel year to be from 1 to n_year instead of the actual year.
gen year_rlb = .
foreach num of numlist 1(1)`n_year'{
	replace year_rlb = `num' if d_t`num' == 1
}

