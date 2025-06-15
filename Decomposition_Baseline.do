*** This is the code for doing the baselinse HLT decomposition *** (for producing figure 4) ***

clear
cd "E:\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Data"
use "CPS_Cleaned.dta"

*** Let's try to do figure 4 exactly first. Hence, use data from 1986 - 2012. And restrict sample to those born from 1935 - 1984

keep if year >= 1986 & year <= 2012
keep if ybirth >= 1935 & ybirth <= 1984

* gen exp bins
egen wexp_group = cut(exp_baseline), at(0(5)40) // working life = 40 yrs old. Incrementing from 0 by 5 each step.

drop if wexp_group == . // use only those in interested experience groups (no negative experience or over 40 years)

// get number of experience groups.
tab wexp_group
local n_wexp = r(r)		// number of experience groups

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

** Create Deaton's time vriables.
* gen time dummy (This is only used for relabelling later on and create Deaton's time dummy)
tab year, g(d_t) // dummies for each year
local n_year = r(r)	

// relabel year to be from 1 to n_year instead of the actual year.
gen year_rlb = .
foreach num of numlist 1(1)`n_year'{
	replace year_rlb = `num' if d_t`num' == 1
}

* gen Deaton's time variables.
foreach num of numlist 3(1) `n_year' {
	// dt* = dt-(t-1)*d2+(t-2)*d1		[see Deaton(1997, p126) equation (2.95)]
	gen d_t`num'star=d_t`num'-(`num'-1)*d_t2+(`num'-2)*d_t1
}

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
global flat_start 6		// starting point for flat spot (the 7th and 8th bins)
global flat_end 8		// ending point for flat spot

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

* Intitial guess g_0
reg logrealwage i.wexp_group year_rlb
local g_0 = _b[year_rlb]
display "Intial growth of the linear time trend (g_0): `g_0'"

gen growth_y = `g_0'

* Deflating the wage
gen Def_logrealwage = logrealwage - growth_y*(year_rlb - 1)

* Decomposing (the main regression)
reg Def_logrealwage i.wexp_group i.coh_rlb d_*star [pweight=perwt] // (they used aweight, I think pweight is more appropriate)
mat coef_mat=e(b) // store the estimated coeff in a matrix.

* Fill in the profiles using the estimated coefficients. *** These will become a new dataset at the end.
gen profile_wexp = .
gen profile_coh = .
gen profile_year = .
gen profile_wexp_plot = . // These will be x-axis
gen profile_coh_plot = .
gen profile_year_plot = .

* 3.7 Fill In Profiles using estimated coefficients in regression. (Earning profiles are decomposed into cohort, experience, and time profile. The first difference of the profiles are the effects.)
local n_year2 = `n_year' - 2			// number of effective coefficients for year

replace profile_wexp = 0 if _n == 1 // (since it is the base group) (_n is the row number)
replace profile_wexp_plot = 1 if _n == 1
replace profile_year_plot = 1 if _n == 1
replace profile_year_plot = 2 if _n == 2

* Experience Profile
foreach num of numlist 2(1)`n_wexp' { // have to start from 2 since the first is the coeff of base group, which is = 0.
	replace profile_wexp = coef_mat[1,`num'] if _n==`num' //accesing the first row, and `num' column of the matrix. This works since we put the coefficients of exp bins to come first.
	replace profile_wexp_plot = `num' if _n==`num'
}

* Cohort Profile
replace profile_coh = 0 if _n == 1 // since it is the base group.
replace profile_coh_plot = 1 if _n == 1
foreach num of numlist 2(1)`n_cohort' { // have to start from 2 since the first is the coeff of base group, which is = 0.
	replace profile_coh = coef4[1, `n_wexp' + `num'] if _n==`num' // since the coeff of cohort come after the coeff of experience groups.
	replace profile_coh_plot = `num'  if _n==`num'
}

* Year Profile (Note: this step takes into account that repeated cross-section might be NOT at an yearly frequency)
foreach num of numlist 1(1)`n_year2' {
	replace profile_year = coef4[1,`n_wexp' + `n_cohort' + `num'] if _n==`num' +2
	replace profile_year_plot = `num' + 2 if _n==`num' +2
}

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
replace profile_year = (1/s_y[1])*(((s_y[2]/s_y[1])-1)*fi - (s_y[2]/s_y[1])*psi) if _n == 1
replace profile_year = (psi - fi)/(s_y[1]) if _n == 2

* Next, check wheter we manage to make flat spot assumption holds.
 

** Loop
while `diff' > $precision & `iter' < $max_iter{


** The algorithm initialize only if there are enough observations
if bin_obs_temp_min[1]>$min_obs & `num_wexp' == $max_wexp/$bin_wexp  { 
	*** (1) the minimal number of observations among all year-experience bins > $min_obs
	*** (2) number of experience groups == $max_wexp/$bin_wexp (i.e. 40/5)
	
	// preallocate some variables, which are used for convergence
	gen growth_wexp = .
	gen wexp_high = .
	gen wexp_low = .

	
	gen s_y = 1 if _n == 1			//  s_y = (1,2,3,...,n_year)'
	foreach num of numlist 2(1)`n_year'{
		gen temp1 = year_rlb if d`num' == 1
		egen temp2 = mean(temp1)
		replace temp1 = temp2
		replace s_y = temp1 if _n == `num'
		drop temp*
	}

	
	tab year, gen(year_mm)
	local n_year_mm = r(r)				// number of years
	

	* 2.5 Generate Average weights used to calculate growth *
	bys year: egen tot_pers =sum(perwt)
	replace perwt = perwt/tot_pers			
	bys year: egen av_perwt = mean(perwt)

	********************************************************************************
	* 3. CONVERGENCE LOOP 

	* 3.1 Set initial values
	local iter = 1
	local dif = 1

	while `dif' > $precision & `iter' < $max_iter{

		* 3.2 Reset Profiles to be Calculated
		gen profile_6 = .
		drop profile_*
		
		gen profile_wexp = .
		gen profile_coh = .
		gen profile_year = .
		gen profile_wexp_plot = .
		gen profile_coh_plot = .
		gen profile_year_plot = .
		

		* 3.3 Calculate initial guess for growth rate (only for first iter)
		if `iter' == 1{
			reg lwage eduyrs i.wexp_group 
			predict lwage_hat, xb
			gen res_hat = lwage - lwage_hat
			reg res_hat year_rlb			// year_rlb: label year from 1 to the number of years
			gen b_year = _b[year_rlb]		
			gen growth_y = b_year 
			gen growth_c = 0
		}

		* 3.4 Update Iter
		local iter = `iter' + 1

		if `iter' > 1{

			* 3.5 Deflate data using guess of growth rate
			gen lwage_temp = lwage - growth_y*(year_rlb - 1)

			* 3.6 Estimate Deaton Profiles using standard Deatons method that restricts year effect to sum to 0 (in deflated data)
			*** switch between median regression and OLS
			if $ctrledu == 1{
				if $medreg == 1{			
					xi : qreg2 lwage_temp eduyrs i.wexp_group i.coh_rlb d*star 
				}
				if $medreg == 0{
					xi : reg lwage_temp eduyrs i.wexp_group i.coh_rlb d*star [aweight=perwt]
				}
				gen wage_hat = eduyrs*_b[eduyrs]
			}
			if $ctrledu == 0 {
				if $medreg == 1 {			
					xi : qreg2 lwage_temp i.wexp_group i.coh_rlb d*star 
				}
				if $medreg == 0 {
					xi : reg lwage_temp i.wexp_group i.coh_rlb d*star [aweight=perwt]
				}
				gen wage_hat = 0
			}
			replace cons_term = _b[_cons]
						
			sum wexp_group	
			forvalues iexp = $bin_wexp($bin_wexp)`r(max)' {
				replace wage_hat = wage_hat + _Iwexp_grou_`iexp'*_b[_Iwexp_grou_`iexp']
			}
			
			replace wage_hat = exp(wage_hat)*perwt/av_perwt
			sort year 
			by year: egen tot_weight = sum(wage_hat)		// tot_weight: Fbar_t
			mat coef4=e(b)									// regression coefficients
			local help=colsof(coef4)

			

			* 3.5 Calculate the Growth Rates And Update Year Growth According to Choosed Restrictions
			* Year and Cohort Effects
			gen coho_eff = .
			foreach num of numlist 2(1)`n_cohort'{
				replace coho_eff = _Icoh_rlb_`num'*profile_coh[`num' - 1] if _Icoh_rlb_`num' == 1 
			}
			replace coho_eff = exp(coho_eff)*wage_hat
			gen year_eff = .
			foreach num of numlist 1(1)`n_year_mm'{
				egen temp`num' = mean(profile_year[`num'])
				replace year_eff = temp`num' if year_mm`num' == 1
			}

			* Last Ten Years
			replace wexp_high = profile_wexp[$flat_end]
			replace wexp_low = profile_wexp[$flat_start]
			local flat_length = ($flat_end - $flat_start)*5
			replace growth_wexp = (wexp_high - wexp_low)/`flat_length' + $delta

			* Cohort Growth (See Notes on LMPQS Appendix. The cohort growth is weighted by the number of active people from each cohort). 
			sort year
			by year: egen coho_tot_eff = sum(coho_eff)
			replace coho_tot_eff = coho_tot_eff/tot_weight
			replace coho_tot_eff = log(coho_tot_eff)
			reg coho_tot_eff year_rlb
			replace growth_c = _b[year_rlb]
			* Year Growth
			gen growth_y0 = growth_y	
			replace growth_y = growth_y0 + $dump*growth_wexp
			local dif = abs(growth_y - growth_y0)/abs(growth_y + growth_c)
			// do not define dif as growth_exp; this definition makes dif more salient
			drop growth_y0
			if `dif' > $precision{
				drop *eff* *weight* wage_hat *temp* psi fi 
			}
		}
	}
	
	rename growth_wexp growth_w
	gen iter = `iter'
