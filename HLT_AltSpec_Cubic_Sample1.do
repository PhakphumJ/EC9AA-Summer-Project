*** This is the code for doing the decomposition using HLT assumption with alternative specification ***

clear
cd "C:\Users\fphak\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project"
use "Data\CPS_Cleaned_UnCr.dta"

keep if ybirth >= 1910 & ybirth <= 1994 // 17 cohorts. 
drop if year == 1962 // since 'educ' is not available.

* gen exp bins
egen wexp_group = cut(exp_baseline), at(0(5)40) // working life = 40 yrs old. Incrementing from 0 by 5 each step.

drop if wexp_group == . // use only those in interested experience groups (no negative experience or over 40 years)

* We are not creating experience bins this time.
keep if exp_baseline >= 0 & exp_baseline <= 39

gen exp_bar = 0 // zero yhat at exp_bar 
gen exp_lin = exp_baseline - exp_bar
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

** Create Deaton's time vriables.
* gen time dummy (This is only used for relabelling later on and create Deaton's time dummy)
tab year, g(d_t) // dummies for each year
local n_year = r(r)	
sum year
local min_y = r(min)
local max_y = r(max)
local n_year_true = `max_y' - `min_y' + 1
display "#disticnt years: `n_year' periods"
display "#Length of the time period: `n_year_true' years"

// relabel year to be from 1 to n_year instead of the actual year.
// Do year - 1960 instead since the inteval between is not constant. -> 1961 becomes 1
gen year_rlb = year - 1960

* gen Deaton's time variables.
foreach num of numlist 3(1) `n_year' {
	// dt* = dt-(t-1)*d2+(t-2)*d1		[see Deaton(1997, p126) equation (2.95)]
	gen dea_t`num'star=d_t`num'-(`num'-1)*d_t2+(`num'-2)*d_t1
}

drop d_t* // to reduce memory usage.

* Drop those with missing values
drop if wexp_group == . | eduyrs == . | logrealwage == . | ybirth == .

* Normalizing the weights in each year -> mass of 1 in each year. (Is this a proper thing to do?)
rename asecwt perwt
bys year: egen tot_pers =sum(perwt)
replace perwt = perwt/tot_pers			
bys year: egen av_perwt = mean(perwt)
********************************************************************************
* 1. PARAMETERS 
********************************************************************************
global medreg 0			// whether perform median regression or not
global ctrledu 0		// whether control education or not
global min_obs 0		// set minumum number of observations in each year/experience bin. (Suggested 10 or >)
global max_iter 50 		// maximum number of iteration (to stop if algorithm does not convergence)
global precision 0.0001 // percentage gap between growth rates at convergence. 
global dump 0.7 		// dumping factor useful to achieve convergence. Should be not too small relative to precision, or you get fake convergence. 
global delta 0 			// depreciation rate for HLT
global bin_coh 5		// length of cohort bins
global bin_wexp 5		// length of experience bins
global max_wexp 40		// maximum years of experience of interest [should be multiple of $bin_coh]
global flat_start 29		// starting point for flat spot (going from 29 to 30 should not have any effect.)
global flat_end 39		// ending point for flat spot

********************************************************************************
* 2. Creating temp variables for checking num. of obs. before running the algo. 
********************************************************************************

* Check that there is sufficient number of observations in each year-experience bin
*** (1) the minimal number of observations among all year-experience bins > $min_obs
gen one_temp = 1
sort year wexp_group
egen group_temp = group(year wexp_group) // create pair numbers (year-experience bin pairs)
bysort group_temp: egen bin_obs_temp = sum(one_temp)	// bin_obs_temp: number of observations in each year-experience bin
egen bin_obs_temp_min = min(bin_obs_temp)			// bin_obs_temp_min: the minimal number of observations among all year-experience bins

*** (2) number of experience groups
tab wexp_group
local num_wexp = r(r)								// `num_wexp': number of experience groups

*** (3) number of experience groups per year
tab year
local n_year = r(r)
tab group_temp
local n_group = r(r)
local n_wexp_per_year = `n_group' / `n_year'


********************************************************************************
* 3. Running the algorithm
********************************************************************************


** Let's try to do on my own first.

** Initilize
gen cons_term = .
local iter = 1
local diff = 1 // (we want to minimize this.)

// preallocate some variables, which are used for convergence
gen growth_wexp = . //(growth of exp effect in the last working years)
gen wexp_high = . //(exp effect in the last bin)
gen wexp_low = . //(exp effect in the first bin of the flat part)

* pre-allocate columns for storing the estimated effects. *** These will become a new dataset at the end.
gen profile_wexp = .
gen profile_coh = .
gen profile_year = .
gen profile_wexp_plot = . // These will be x-axis
gen profile_coh_plot = .
gen profile_year_plot = .

gen exp_lin_eff = .
gen exp_sq_eff = .
gen exp_cb_eff = .

* Intitial guess g_0
reg logrealwage i.wexp_group year_rlb
local g_0 = _b[year_rlb]
display "Intial growth of the linear time trend (g_0): `g_0'"


gen growth_m_plusone = .

** Algorithm Loop
while `diff' > $precision & `iter' < $max_iter{
	// reset the profile
	replace profile_wexp = .
	replace profile_coh = .
	replace profile_year = .
	
	if `iter' == 1{
		gen growth_m = `g_0'
	}
	
	if `iter' > 1 {
		replace growth_m = growth_m_plusone
	}
	
	* Deflating the wage
	gen Def_logrealwage_temp = logrealwage - growth_m*(year_rlb - 1)
	
	* Decomposing (the main regression)
	reg Def_logrealwage_temp exp_lin exp_sq exp_cube i.coh_rlb dea_*star [pweight=perwt] // (they used aweight, I think pweight is more appropriate) 
	
	replace cons_term = _b[_cons]
	mat coef_mat=e(b) // store the estimated coeff in a matrix.
	
	* 3.7 Fill In Profiles using estimated coefficients in regression. 
	local n_year2 = `n_year' - 2 // number of effective coefficients for year

	* Experience Profile
	foreach num of numlist 1(1)`n_exp'{
	replace profile_wexp_plot  = `num' - 1 if _n == `num' 
	} // it generates 0,1,2,...39
	
	replace exp_lin_eff = coef_mat[1,1]
	replace exp_sq_eff = coef_mat[1,2]
	replace exp_cb_eff = coef_mat[1,3]
	
	replace profile_wexp = exp_lin_eff*(profile_wexp_plot - exp_bar) + exp_sq_eff*(profile_wexp_plot - exp_bar)^2 + exp_cb_eff*(profile_wexp_plot - exp_bar)^3

	* Cohort Profile
	replace profile_coh = 0 if _n == 1 // since it is the base group.
	replace profile_coh_plot = 1 if _n == 1
	foreach num of numlist 2(1)`n_cohort' { // have to start from 2 since the first is the coeff of base group, which is = 0.
		replace profile_coh = coef_mat[1, 3 + `num'] if _n==`num' // since the coeff of cohort come after the coeff of experience groups (first three coef).
		replace profile_coh_plot = `num'  if _n==`num'
	}

	* Year Profile (Note: this step takes into account that repeated cross-section might be NOT at an yearly frequency)
	replace profile_year_plot = 1 if _n == 1
	replace profile_year_plot = 2 if _n == 2
	
	foreach num of numlist 1(1)`n_year2' {
		replace profile_year = coef_mat[1, 3 + `n_cohort' + `num'] if _n==`num' +2
		replace profile_year_plot = `num' + 2 if _n==`num' +2
	}

	* Solve for the first two time effects, i.e. gamma_1, gamma_2. ((1) sum of time effects = 0, (2) sum of s' Gamma = 0)
	gen s_y = profile_year_plot //(s_y = (1,2,..., n_year))


	gen temp_1 = . 
	foreach num of numlist 3(1)`n_year'{
		replace temp_1 = s_y[`num'-1] - s_y[`num'-2] if _n == `num'
	}

	gen temp_2 = temp_1 * profile_year
	egen psi = sum(temp_2)
	gen temp_4 = sum(temp_1)
	replace temp_4 = temp_4 + s_y[2] 
	gen temp_5 = temp_4 * profile_year
	egen fi = sum(temp_5)
	// These are analytical soln for the 1st and 2nd time effects. 
	replace profile_year = (1/s_y[1])*(((s_y[2]/s_y[1])-1)*fi - (s_y[2]/s_y[1])*psi) if _n == 1
	replace profile_year = (psi - fi)/(s_y[1]) if _n == 2
	
	* Next, check wheter we manage to make flat spot assumption holds.
	* Extract the experience effect in the Last Ten Years (for baseline assumption, exp effect in the 6th, 7th, and 8th bins should be the same) (*** I don't like how they did this. Since, they are using only the begining and the end of the flat parts. -> Produce a hump in the middle.)
	summarize profile_wexp if profile_wexp_plot == $flat_end, meanonly
	local wexp_high_scal = r(mean)
	
	summarize profile_wexp if profile_wexp_plot == $flat_start, meanonly
	local wexp_low_scal = r(mean)
	
	replace wexp_high = `wexp_high_scal'
	replace wexp_low = `wexp_low_scal'
	
	local flat_length = $flat_end - $flat_start //number of years in the flat part.
	
	replace growth_wexp = (wexp_high - wexp_low)/`flat_length' + $delta // i.e. average growth in the last 10 years.

	* Update the growth of time effect g^{m+1} = g^m + \delta * r^m_{end}
	replace growth_m_plusone = growth_m + $dump*growth_wexp
	local diff = abs(growth_m_plusone - growth_m)/abs(growth_m)

	display "The difference is: `diff'"
	
	if `diff' > $precision{ 
		drop *temp* s_y psi fi
	}
	
	local iter = `iter' + 1
}

gen iter = `iter' - 1

********************************************************************************
* 4. Prepare data for plotting (keeping only relevant variables and converting thing from log to levels)
********************************************************************************
// cannot multiply (1,2,3..) to growth since the intervals b/w years are not equal.
// The years are 1961, 1963, 1964, 1965, ...
// Hence, we want s_y to be 1,3,4,... instead of (1,2,3,...30)
gen s_y_relabel = s_y 
replace s_y_relabel = s_y + 1
replace s_y_relabel = 1 if _n == 1

gen profile_year_cyc = profile_year // this is the cyclical part
replace profile_year = profile_year*(s_y[1]) if _n==1 // the trend of time effects
replace profile_year = profile_year*(s_y[_n] - s_y[_n - 1]) + growth_m*(s_y_relabel - s_y_relabel[1]) if _n >1 // time effect = trend + cylical// time effect = trend + cylical
replace profile_wexp = exp(profile_wexp) // converting to levels
replace profile_year = exp(profile_year) // converting to levels
replace profile_coh = exp(profile_coh) // converting to levels


egen min_year = min(year)
gen plot_year = s_y_relabel + min_year - s_y_relabel[1] // (so that we have the years in the x-axis)

egen coho_min = min(byear)
egen coho_max = max(byear)
gen plot_coh  = coho_min
gen coho_gap = coho_max - coho_min
local n_coho = coho_gap[1]/$bin_coh + 1
display `n_coho'
foreach num of numlist 2(1)`n_coho'{
	replace plot_coh  = plot_coh + (`num' - 1)*$bin_coh if _n == `num'
} // so for the second cohort, it is the min_ybrith + 1*5. For second cohort, it is min_ybirth + 2*5

gen plot_wexp = profile_wexp_plot


keep if profile_year !=. | profile_coh!=. | profile_wexp!=. // dropping rows not containing the data for plotting. 
keep profile_* plot_* growth_m iter cons_term // keeping only relevant columns for plotting.
drop profile*plot

save "Data\Temp\HLT_results_sample1_UnCr_AltSpec_cubic.dta", replace



////////////////////////////////////////////
///// The Below is for doing the same thing but using the dataset with corrected age variable. ///


clear
cd "C:\Users\fphak\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project"
use "Data\CPS_Cleaned_Cr.dta"

keep if ybirth >= 1910 & ybirth <= 1994 // 17 cohorts. 
drop if year == 1962 // since 'educ' is not available.

* gen exp bins
egen wexp_group = cut(exp_baseline), at(0(5)40) // working life = 40 yrs old. Incrementing from 0 by 5 each step.

drop if wexp_group == . // use only those in interested experience groups (no negative experience or over 40 years)

* We are not creating experience bins this time.
keep if exp_baseline >= 0 & exp_baseline <= 39

gen exp_bar = 0 // zero yhat at exp_bar 
gen exp_lin = exp_baseline - exp_bar
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

** Create Deaton's time vriables.
* gen time dummy (This is only used for relabelling later on and create Deaton's time dummy)
tab year, g(d_t) // dummies for each year
local n_year = r(r)	
sum year
local min_y = r(min)
local max_y = r(max)
local n_year_true = `max_y' - `min_y' + 1
display "#disticnt years: `n_year' periods"
display "#Length of the time period: `n_year_true' years"

// relabel year to be from 1 to n_year instead of the actual year.
// Do year - 1960 instead since the inteval between is not constant. -> 1961 becomes 1
gen year_rlb = year - 1960

* gen Deaton's time variables.
foreach num of numlist 3(1) `n_year' {
	// dt* = dt-(t-1)*d2+(t-2)*d1		[see Deaton(1997, p126) equation (2.95)]
	gen dea_t`num'star=d_t`num'-(`num'-1)*d_t2+(`num'-2)*d_t1
}

drop d_t* // to reduce memory usage.

* Drop those with missing values
drop if wexp_group == . | eduyrs == . | logrealwage == . | ybirth == .

* Normalizing the weights in each year -> mass of 1 in each year. (Is this a proper thing to do?)
rename asecwt perwt
bys year: egen tot_pers =sum(perwt)
replace perwt = perwt/tot_pers			
bys year: egen av_perwt = mean(perwt)
********************************************************************************
* 1. PARAMETERS 
********************************************************************************
global medreg 0			// whether perform median regression or not
global ctrledu 0		// whether control education or not
global min_obs 0		// set minumum number of observations in each year/experience bin. (Suggested 10 or >)
global max_iter 50 		// maximum number of iteration (to stop if algorithm does not convergence)
global precision 0.0001 // percentage gap between growth rates at convergence. 
global dump 0.7 		// dumping factor useful to achieve convergence. Should be not too small relative to precision, or you get fake convergence. 
global delta 0 			// depreciation rate for HLT
global bin_coh 5		// length of cohort bins
global bin_wexp 5		// length of experience bins
global max_wexp 40		// maximum years of experience of interest [should be multiple of $bin_coh]
global flat_start 29		// starting point for flat spot (going from 29 to 30 should not have any effect.)
global flat_end 39		// ending point for flat spot

********************************************************************************
* 2. Creating temp variables for checking num. of obs. before running the algo. 
********************************************************************************

* Check that there is sufficient number of observations in each year-experience bin
*** (1) the minimal number of observations among all year-experience bins > $min_obs
gen one_temp = 1
sort year wexp_group
egen group_temp = group(year wexp_group) // create pair numbers (year-experience bin pairs)
bysort group_temp: egen bin_obs_temp = sum(one_temp)	// bin_obs_temp: number of observations in each year-experience bin
egen bin_obs_temp_min = min(bin_obs_temp)			// bin_obs_temp_min: the minimal number of observations among all year-experience bins

*** (2) number of experience groups
tab wexp_group
local num_wexp = r(r)								// `num_wexp': number of experience groups

*** (3) number of experience groups per year
tab year
local n_year = r(r)
tab group_temp
local n_group = r(r)
local n_wexp_per_year = `n_group' / `n_year'


********************************************************************************
* 3. Running the algorithm
********************************************************************************


** Let's try to do on my own first.

** Initilize
gen cons_term = .
local iter = 1
local diff = 1 // (we want to minimize this.)

// preallocate some variables, which are used for convergence
gen growth_wexp = . //(growth of exp effect in the last working years)
gen wexp_high = . //(exp effect in the last bin)
gen wexp_low = . //(exp effect in the first bin of the flat part)

* pre-allocate columns for storing the estimated effects. *** These will become a new dataset at the end.
gen profile_wexp = .
gen profile_coh = .
gen profile_year = .
gen profile_wexp_plot = . // These will be x-axis
gen profile_coh_plot = .
gen profile_year_plot = .

gen exp_lin_eff = .
gen exp_sq_eff = .
gen exp_cb_eff = .

* Intitial guess g_0
reg logrealwage i.wexp_group year_rlb
local g_0 = _b[year_rlb]
display "Intial growth of the linear time trend (g_0): `g_0'"


gen growth_m_plusone = .

** Algorithm Loop
while `diff' > $precision & `iter' < $max_iter{
	// reset the profile
	replace profile_wexp = .
	replace profile_coh = .
	replace profile_year = .
	
	if `iter' == 1{
		gen growth_m = `g_0'
	}
	
	if `iter' > 1 {
		replace growth_m = growth_m_plusone
	}
	
	* Deflating the wage
	gen Def_logrealwage_temp = logrealwage - growth_m*(year_rlb - 1)
	
	* Decomposing (the main regression)
	reg Def_logrealwage_temp exp_lin exp_sq exp_cube i.coh_rlb dea_*star [pweight=perwt] // (they used aweight, I think pweight is more appropriate) 
	
	replace cons_term = _b[_cons]
	mat coef_mat=e(b) // store the estimated coeff in a matrix.
	
	* 3.7 Fill In Profiles using estimated coefficients in regression. 
	local n_year2 = `n_year' - 2 // number of effective coefficients for year

	* Experience Profile
	foreach num of numlist 1(1)`n_exp'{
	replace profile_wexp_plot  = `num' - 1 if _n == `num' 
	} // it generates 0,1,2,...39
	
	replace exp_lin_eff = coef_mat[1,1]
	replace exp_sq_eff = coef_mat[1,2]
	replace exp_cb_eff = coef_mat[1,3]
	
	replace profile_wexp = exp_lin_eff*(profile_wexp_plot - exp_bar) + exp_sq_eff*(profile_wexp_plot - exp_bar)^2 + exp_cb_eff*(profile_wexp_plot - exp_bar)^3

	* Cohort Profile
	replace profile_coh = 0 if _n == 1 // since it is the base group.
	replace profile_coh_plot = 1 if _n == 1
	foreach num of numlist 2(1)`n_cohort' { // have to start from 2 since the first is the coeff of base group, which is = 0.
		replace profile_coh = coef_mat[1, 3 + `num'] if _n==`num' // since the coeff of cohort come after the coeff of experience groups (first three coef).
		replace profile_coh_plot = `num'  if _n==`num'
	}

	* Year Profile (Note: this step takes into account that repeated cross-section might be NOT at an yearly frequency)
	replace profile_year_plot = 1 if _n == 1
	replace profile_year_plot = 2 if _n == 2
	
	foreach num of numlist 1(1)`n_year2' {
		replace profile_year = coef_mat[1, 3 + `n_cohort' + `num'] if _n==`num' +2
		replace profile_year_plot = `num' + 2 if _n==`num' +2
	}

	* Solve for the first two time effects, i.e. gamma_1, gamma_2. ((1) sum of time effects = 0, (2) sum of s' Gamma = 0)
	gen s_y = profile_year_plot //(s_y = (1,2,..., n_year))


	gen temp_1 = . 
	foreach num of numlist 3(1)`n_year'{
		replace temp_1 = s_y[`num'-1] - s_y[`num'-2] if _n == `num'
	}

	gen temp_2 = temp_1 * profile_year
	egen psi = sum(temp_2)
	gen temp_4 = sum(temp_1)
	replace temp_4 = temp_4 + s_y[2] 
	gen temp_5 = temp_4 * profile_year
	egen fi = sum(temp_5)
	// These are analytical soln for the 1st and 2nd time effects. 
	replace profile_year = (1/s_y[1])*(((s_y[2]/s_y[1])-1)*fi - (s_y[2]/s_y[1])*psi) if _n == 1
	replace profile_year = (psi - fi)/(s_y[1]) if _n == 2
	
	* Next, check wheter we manage to make flat spot assumption holds.
	* Extract the experience effect in the Last Ten Years (for baseline assumption, exp effect in the 6th, 7th, and 8th bins should be the same) (*** I don't like how they did this. Since, they are using only the begining and the end of the flat parts. -> Produce a hump in the middle.)
	summarize profile_wexp if profile_wexp_plot == $flat_end, meanonly
	local wexp_high_scal = r(mean)
	
	summarize profile_wexp if profile_wexp_plot == $flat_start, meanonly
	local wexp_low_scal = r(mean)
	
	replace wexp_high = `wexp_high_scal'
	replace wexp_low = `wexp_low_scal'
	
	local flat_length = $flat_end - $flat_start //number of years in the flat part.
	
	replace growth_wexp = (wexp_high - wexp_low)/`flat_length' + $delta // i.e. average growth in the last 10 years.

	* Update the growth of time effect g^{m+1} = g^m + \delta * r^m_{end}
	replace growth_m_plusone = growth_m + $dump*growth_wexp
	local diff = abs(growth_m_plusone - growth_m)/abs(growth_m)

	display "The difference is: `diff'"
	
	if `diff' > $precision{ 
		drop *temp* s_y psi fi
	}
	
	local iter = `iter' + 1
}

gen iter = `iter' - 1

********************************************************************************
* 4. Prepare data for plotting (keeping only relevant variables and converting thing from log to levels)
********************************************************************************
// cannot multiply (1,2,3..) to growth since the intervals b/w years are not equal.
// The years are 1961, 1963, 1964, 1965, ...
// Hence, we want s_y to be 1,3,4,... instead of (1,2,3,...30)
gen s_y_relabel = s_y 
replace s_y_relabel = s_y + 1
replace s_y_relabel = 1 if _n == 1

gen profile_year_cyc = profile_year // this is the cyclical part
replace profile_year = profile_year*(s_y[1]) if _n==1 // the trend of time effects
replace profile_year = profile_year*(s_y[_n] - s_y[_n - 1]) + growth_m*(s_y_relabel - s_y_relabel[1]) if _n >1 // time effect = trend + cylical// time effect = trend + cylical
replace profile_wexp = exp(profile_wexp) // converting to levels
replace profile_year = exp(profile_year) // converting to levels
replace profile_coh = exp(profile_coh) // converting to levels


egen min_year = min(year)
gen plot_year = s_y_relabel + min_year - s_y_relabel[1] // (so that we have the years in the x-axis)

egen coho_min = min(byear)
egen coho_max = max(byear)
gen plot_coh  = coho_min
gen coho_gap = coho_max - coho_min
local n_coho = coho_gap[1]/$bin_coh + 1
display `n_coho'
foreach num of numlist 2(1)`n_coho'{
	replace plot_coh  = plot_coh + (`num' - 1)*$bin_coh if _n == `num'
} // so for the second cohort, it is the min_ybrith + 1*5. For second cohort, it is min_ybirth + 2*5

gen plot_wexp = profile_wexp_plot


keep if profile_year !=. | profile_coh!=. | profile_wexp!=. // dropping rows not containing the data for plotting. 
keep profile_* plot_* growth_m iter cons_term // keeping only relevant columns for plotting.
drop profile*plot

save "Data\Temp\HLT_results_sample1_Cr_AltSpec_cubic.dta", replace