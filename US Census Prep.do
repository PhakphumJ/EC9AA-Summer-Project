*** This do-file is for replicating the figures in Fang and Qiu (2023). 
** Using CPS data from (i) 1986-2013 (survey year), and (ii) 1962-2024 (survey year). 
** or (i) 1986 - 2012 and (ii) 1961 - 2023 (income year)

** We will create two versions of dataset. 1. 1 is subtraced from year ("Uncorrected Age" sample); 2. 1 is subtraced from both year and age ("Corrected Age" sample). 

///////// Let's start from the sample with uncorrected age ///////


*** Preparing the data
clear
cd "C:\Users\fphak\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Data"
use usa_census_smallest.dta


* Replace perwt with expwtp in year where expwtp is available. 
replace perwt = expwtp if expwtp != .
drop expwtp statefip

* subtract 1 from year (since income variable is the income earned last year)
replace year = year - 1

* drop those with weight < 0 (Note: These are valid weights)
drop if perwt < 0 // there are no obs with negative weight in the census.


** create real wage variable and its log
* replacing incwage missing wages and zero wages with NA.
replace incwage = . if incwage == 999999 | incwage == 999998 | incwage == 0 | incwage == . 


merge m:1 year using "CPI_1913_to_2024_cleaned.dta"
keep if _merge == 1 | _merge == 3
drop _merge

gen realwage = incwage/CPI
gen logrealwage = log(realwage)

* Create imputed years of schooling
replace educd = . if educd == 1 // replace 1 with NA.

replace educd = . if educd == 999  // replace 999 with NA.


gen eduyrs = . // Create the new variable. Using the same logic in the replication packgage.

replace eduyrs = 0 if educd <= 12
replace eduyrs = 6 if educd >= 13 & educd <= 26
replace eduyrs = 9 if educd >= 30 & educd <= 50
replace eduyrs = 12 if educd >= 60 & educd <= 71
replace eduyrs = 14 if educd >= 80 & educd <= 90
replace eduyrs = 16 if educd >= 100 & educd <= 113
replace eduyrs = 18 if educd >= 114 & educd <= 115
replace eduyrs = 20 if educd == 116

drop educd educ

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

* Use only male workers
keep if sex == 1

* drop outlier
drop if outlier == 1

** Export the data
save "US_Census_Cleaned_UnCr.dta", replace 


///// The code below is for creating the dataset with corrected age variable (age = age - 1). ///
*** Preparing the data
clear
cd "C:\Users\fphak\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Data"
use usa_census_smallest.dta


* Replace perwt with expwtp in year where expwtp is available. 
replace perwt = expwtp if expwtp != .
drop expwtp statefip

* subtract 1 from year and age (since income variable is the income earned last year)
replace age = age - 1
replace year = year - 1

* drop those with weight < 0 (Note: These are valid weights)
drop if perwt < 0 // there are no obs with negative weight in the census.


** create real wage variable and its log
* replacing incwage missing wages and zero wages with NA.
replace incwage = . if incwage == 999999 | incwage == 999998 | incwage == 0 | incwage == . 


merge m:1 year using "CPI_1913_to_2024_cleaned.dta"
keep if _merge == 1 | _merge == 3
drop _merge

gen realwage = incwage/CPI
gen logrealwage = log(realwage)

* Create imputed years of schooling
replace educd = . if educd == 1 // replace 1 with NA.

replace educd = . if educd == 999  // replace 999 with NA.


gen eduyrs = . // Create the new variable. Using the same logic in the replication packgage.

replace eduyrs = 0 if educd <= 12
replace eduyrs = 6 if educd >= 13 & educd <= 26
replace eduyrs = 9 if educd >= 30 & educd <= 50
replace eduyrs = 12 if educd >= 60 & educd <= 71
replace eduyrs = 14 if educd >= 80 & educd <= 90
replace eduyrs = 16 if educd >= 100 & educd <= 113
replace eduyrs = 18 if educd >= 114 & educd <= 115
replace eduyrs = 20 if educd == 116

drop educd educ

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

* Use only male workers
keep if sex == 1

* drop outlier
drop if outlier == 1

** Export the data
save "US_Census_Cleaned_Cr.dta", replace 
