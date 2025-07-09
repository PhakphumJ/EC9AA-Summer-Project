*** This do-file is for the alternative specification where instead of using the full set of experience bin dummies, the squared and cubic of (experience - experience_bar) are included. 

** We have three samples **
* (i) CPS 1961 - 2023
* (ii) US Census 1959 - 2023
* (iii) CPS 1961 - 2023 (using only the years available in the US Census).

*****************************************
* Let's start from the full CPS sample **
*****************************************
/// Preparing the sample ///
clear
cd "/home/phakphum/WarwickPhD/EC9AA Summer Project"
use "Data/CPS_Cleaned.dta"

drop if year == 1962 // since no eduyrs.
keep if ybirth >= 1910 & ybirth <= 1994 // 17 cohorts.

* We are not creating experience bins this time.
keep if exp_baseline >= 0 & exp_baseline <= 39

gen exp_bar = 35 // zero effects at exp_bar 
gen exp_sq = (exp_baseline - exp_bar)^2
gen exp_cube = (exp_baseline - exp_bar)^3

tab exp_baseline
local n_exp = r(r) // store number of exp. 

* gen cohort bins (from [the minimum ybirth rounded to a multiple of 5] to [the maximum of ybirth rounded to be multiple of 5]) (e.g. from 1870 t0 2024)
sum ybirth
local min_ybirth = r(min)
display "The minimum of ybirth is: `min_ybirth'"
local max_ybirth = r(max)
display "The maximum of ybirth is: `max_ybirth'"

// Rounding up and down
local rounded_min_ybirth = floor(`min_ybirth' / 5) * 5
local rounded_up_max_ybirth = ceil(`max_ybirth' / 5) * 5

display "The rounded downed minimum to a multiple of 5 is: `min_ybirth'"
display "The rounded up maximum to a multiple of 5 is: `rounded_up_max_ybirth'"

// Gen the birth year group variable
egen byear_group = cut(ybirth), at (`rounded_min_ybirth'(5)`rounded_up_max_ybirth')

// create dummy variables based on this. (This is only used for relabelling later on)
tab byear_group, g(d_c) // dummies for each cohort bin (g() means generate dummies)
local n_cohort = r(r) // store number of cohort bins

// relabel cohort from 1 to the number of cohort bins (instead of the labelling by the first year of each bin)
gen coh_rlb = .		
foreach num of numlist 1(1)`n_cohort'{ //(use the `n_cohort' list, starting from the first, then incrementing by 1 each time.
	replace coh_rlb = `num' if d_c`num' == 1
}

drop d_c* // to reduce memory usage.

// gen time variable
gen year_rlb = year - 1960

* Drop those with missing values
drop if eduyrs == . | logrealwage == . | ybirth == .


* Normalizing the weights in each year -> mass of 1 in each year. (Is this a proper thing to do?)
rename asecwt perwt
bys year: egen tot_pers =sum(perwt)
replace perwt = perwt/tot_pers			
bys year: egen av_perwt = mean(perwt)

/// Decomposing ///
reg logrealwage exp_sq exp_cube i.coh_rlb i.year_rlb [pweight=perwt]
mat coef_mat=e(b)

/// Storing the results ///
** These are the axes for plotting. 

gen plot_wexp = .
foreach num of numlist 0(1)`n_exp'{
	replace plot_wexp  = `num' if _n == `num' + 1
} // it generates 0,1,2,...39


egen coho_min = min(byear)
gen plot_coh  = coho_min
display `n_cohort'
foreach num of numlist 2(1)`n_cohort'{
	replace plot_coh  = plot_coh + (`num' - 1)*5 if _n == `num'
} // so for the second cohort, it is the min_ybrith + 1*5. For second cohort, it is min_ybirth + 2*5


tab year
local n_year = r(r) // number of years.
egen year_min = min(year)
gen plot_year = year_min
replace plot_year = year_min + 2 if _n == 2 //1963
foreach num of numlist 3(1)`n_year'{
	replace plot_year = plot_year + `num' if _n == `num'
}

** Storing the effects
gen profile_wexp = .
gen profile_coh = .
gen profile_year = .

// experience
gen exp_sq_eff = coef_mat[1,1]
gen exp_cb_eff = coef_mat[1,2]
replace profile_wexp = exp_sq_eff*(plot_wexp - exp_bar)^2 + exp_cb_eff*(plot_wexp - exp_bar)^3
replace profile_wexp = exp(profile_wexp) // converting to levels

// cohort
replace profile_coh = 0 if _n == 1 // since it is the base group.
foreach num of numlist 2(1)`n_cohort' { // have to start from 2 since the first is the coeff of base group, which is = 0.
	replace profile_coh = coef_mat[1,`num' + 2] if _n==`num' // since the coeff of cohort come after the coeff of exp and the first cohort group (base).
}
replace profile_coh = exp(profile_coh) // converting to levels

// time
foreach num of numlist 1(1)`n_year'{
	replace profile_year = coef_mat[1,`n_cohort' + `num' + 2] if _n==`num'
}
replace profile_year = exp(profile_year) // converting to levels


keep if profile_year !=. | profile_coh!=. | profile_wexp!=. // dropping rows not containing the data for plotting. 
keep profile_* plot_* // keeping only relevant columns for plotting.

save "Data/Temp/AltSpec_sample1.dta", replace

*****************************************
* Next, let's do US Census **
*****************************************
/// Preparing the sample ///
clear
cd "/home/phakphum/WarwickPhD/EC9AA Summer Project"
use "Data/US_Census_Cleaned.dta"

drop sex incwage realwage CPI income_bottom2_5pct income_top2_5pct outlier // not useful anymore.

rename birthyr ybirth
keep if year >= 1959 & year <= 2022
keep if ybirth >= 1910 & ybirth <= 1994

* We are not creating experience bins this time.
keep if exp_baseline >= 0 & exp_baseline <= 39

gen exp_bar = 35 // zero effects at exp_bar 
gen exp_sq = (exp_baseline - exp_bar)^2
gen exp_cube = (exp_baseline - exp_bar)^3

tab exp_baseline
local n_exp = r(r) // store number of exp. 

* gen cohort bins (from [the minimum ybirth rounded to a multiple of 5] to [the maximum of ybirth rounded to be multiple of 5]) (e.g. from 1870 t0 2024)
sum ybirth
local min_ybirth = r(min)
display "The minimum of ybirth is: `min_ybirth'"
local max_ybirth = r(max)
display "The maximum of ybirth is: `max_ybirth'"

// Rounding up and down
local rounded_min_ybirth = floor(`min_ybirth' / 5) * 5
local rounded_up_max_ybirth = ceil(`max_ybirth' / 5) * 5

display "The rounded downed minimum to a multiple of 5 is: `min_ybirth'"
display "The rounded up maximum to a multiple of 5 is: `rounded_up_max_ybirth'"

// Gen the birth year group variable
egen byear_group = cut(ybirth), at (`rounded_min_ybirth'(5)`rounded_up_max_ybirth')

// create dummy variables based on this. (This is only used for relabelling later on)
tab byear_group, g(d_c) // dummies for each cohort bin (g() means generate dummies)
local n_cohort = r(r) // store number of cohort bins

// relabel cohort from 1 to the number of cohort bins (instead of the labelling by the first year of each bin)
gen coh_rlb = .		
foreach num of numlist 1(1)`n_cohort'{ //(use the `n_cohort' list, starting from the first, then incrementing by 1 each time.
	replace coh_rlb = `num' if d_c`num' == 1
}

drop d_c* // to reduce memory usage.

// gen time variable
gen year_rlb = year - 1958

* Drop those with missing values
drop if eduyrs == . | logrealwage == . | ybirth == .


* Normalizing the weights in each year -> mass of 1 in each year. (Is this a proper thing to do?)
bys year: egen tot_pers =sum(perwt)
replace perwt = perwt/tot_pers			
bys year: egen av_perwt = mean(perwt)

/// Decomposing ///
reg logrealwage exp_sq exp_cube i.coh_rlb i.year_rlb [pweight=perwt]
mat coef_mat=e(b)
