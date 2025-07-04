*** This do-file is for replicating the figures in Fang and Qiu (2023). 
** Using CPS data from (i) 1986-2013 (survey year), and (ii) 1962-2024 (survey year). 
** or (i) 1986 - 2012 and (ii) 1961 - 2023 (income year)


*** Preparing the data
clear
cd "E:\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Data"
use cps_00004.dta

* drop irrelevant variables (for all analysis)
drop serial month cpsid asecflag hflag statecensus pernum cpsidp cpsidv asecwth

* drop irrelevant variables (for this exercise)
drop race marst occ ind inctot incbus incfarm inclongj oincbus oincfarm oincwage

* subtract 1 from year and age (since income variable is the income earned last year)
*replace age = age - 1
replace year = year - 1

* count obs b/w 1986 - 2012
count if year >= 1986 & year <= 2012
// get #obs = 4,768,394. The data in replication packgage has #obs = 4,768,394. So, we get the exact same number.
// If I did not subtract 1 from year and age, I would have gotten 4,723,421. 

* 
keep if year >= 1986 & year <= 2012


* create male variable
gen male = sex
replace male = 0 if sex == 2



* Create imputed years of schooling
replace educ = . if educ == 1 // replace 1 with NA.


gen eduyrs = . // Create the new variable. Using the same logic in the replication packgage.

replace eduyrs = 0 if educ < 10
replace eduyrs = 6 if educ >= 10 & educ <= 32
replace eduyrs = 9 if educ >= 40 & educ <= 60
replace eduyrs = 12 if educ >= 70 & educ <= 81
replace eduyrs = 14 if educ >= 90 & educ <= 100
replace eduyrs = 16 if educ >= 110 & educ <= 122
replace eduyrs = 18 if educ >= 123 & educ <= 124
replace eduyrs = 20 if educ == 125

* create year-of-birth variable
gen ybirth = year - age

* create experience variable
gen exp_baseline = min(age - eduyrs - 6, age - 18)


* replacing incwage missing wages and zero wages with NA.
replace incwage = . if incwage == 99999999 | incwage == 99999998 | incwage == 0 | incwage == . 



* create real wage variable and its log
merge m:1 year using "E:\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Data\CPI_1913_to_2024_cleaned.dta"
keep if _merge == 1 | _merge == 3
drop _merge


gen realwage = incwage/CPI
gen logrealwage = log(realwage)



* create outlier flag
// Calculate the 2.5th and 97.5th percentile income for each year
gen double income_bottom2_5pct = . 
gen double income_top2_5pct = .

levelsof year, local(years_list) // Stores unique years in a local macro called 'years_list'
foreach y of local years_list {
    display "Processing year: `y'" 
    
    // Calculate 2.5th and 97.5th percentiles for the current year
    _pctile incwage if year == `y', percentiles(2.5 97.5)
    
    local p2_5 = r(r1)
    local p97_5 = r(r2)
	
	// Display the calculated percentiles
    display "  {txt}2.5th Percentile: {res}`p2_5'"
    display "  {txt}97.5th Percentile: {res}`p97_5'"
    
    // Generate the flags for the current year
    
    replace income_bottom2_5pct = (incwage < `p2_5') if year == `y' & incwage != .
    

    replace income_top2_5pct = (incwage > `p97_5') if year == `y' & incwage != .	
}

// Generate the outlier flag
gen outlier = income_bottom2_5pct + income_top2_5pct
