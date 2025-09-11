*** This is the code for doing the baselinse HLT decomposition. But use constrained regression instead of the Deaton-Hall approach. *** 
** This is for helping investigating the odd results of the alternative specification **.

clear
cd "C:\Users\fphak\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project"
use "Data\CPS_Cleaned_UnCr.dta"

*** Do it using Sample 1 with Uncorrected Age ***
keep if ybirth >= 1910 & ybirth <= 1994 // 17 cohorts. 
drop if year == 1962 // since 'educ' is not available.

* gen exp bins
egen wexp_group = cut(exp_baseline), at(0(5)40) // working life = 40 yrs old. Incrementing from 0 by 5 each step.

drop if wexp_group == . // use only those in interested experience groups (no negative experience or over 40 years)

// get number of experience groups.
tab wexp_group, g(d_exp)
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
drop d_c* // to reduce memory usage.

* gen time dummy (This is only used for relabelling the years)
tab year, g(d_t) // dummies for each year
local n_year = r(r)	

// relabel year to be from 1 to n_year instead of the actual year.
gen year_rlb = .
foreach num of numlist 1(1)`n_year'{
	replace year_rlb = `num' if d_t`num' == 1
}

drop d_t* // to reduce memory usage.

* Drop those with missing values
drop if wexp_group == . | eduyrs == . | logrealwage == . | ybirth == .

* Normalizing the weights in each year -> mass of 1 in each year. 
rename asecwt perwt
bys year: egen tot_pers =sum(perwt)
replace perwt = perwt/tot_pers			
bys year: egen av_perwt = mean(perwt)

**************** Decomposition **************
constraint 1 d_exp6 = d_exp7
constraint 2 d_exp7 = d_exp8
cnsreg logrealwage d_exp2 d_exp3 d_exp4 d_exp5 d_exp6 d_exp7 d_exp8 i.coh_rlb i.year_rlb [pweight=perwt], constraint(1,2)
mat coef_mat=e(b) // store the estimated coeff in a matrix.

/// Storing the results ///
** These are the axes for plotting. 

gen plot_wexp = (_n-1)*5 // i.e. 0,5,10,15,...
replace plot_wexp = . if plot_wexp > 35 // keeping only 0-35

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
replace profile_wexp = 0 if _n == 1 // (since it is the base group) (_n is the row number)
foreach num of numlist 2(1)`n_wexp' { 
	replace profile_wexp = coef_mat[1,`num' - 1] if _n==`num' //accesing the first row, and `num' + 1 column of the matrix. This works since we put the coefficients of exp bins to come first.
}
replace profile_wexp = exp(profile_wexp) // converting to levels

// cohort
replace profile_coh = 0 if _n == 1 // since it is the base group.
foreach num of numlist 2(1)`n_cohort' {
	replace profile_coh = coef_mat[1, `n_wexp' + `num' - 1] if _n==`num' // since the coeff of cohort come after the coeff of experience groups.
}
replace profile_coh = exp(profile_coh) // converting to levels

// time
replace profile_year = 0 if _n == 1 // since it is the base group.
foreach num of numlist 2(1)`n_year'{
	replace profile_year = coef_mat[1,`n_wexp' + `n_cohort' + `num' - 1] if _n==`num'
}
replace profile_year = exp(profile_year) // converting to levels


keep if profile_year !=. | profile_coh!=. | profile_wexp!=. // dropping rows not containing the data for plotting. 
keep profile_* plot_* // keeping only relevant columns for plotting.

save "Data\Temp\HLT_ConstrainedReg.dta", replace

**** Plot the results *****
clear 
use "Data\Temp\HLT_ConstrainedReg.dta"


** Experience
replace plot_wexp = plot_wexp + 2.5 // This is the shift the point to the middle of the bins.

twoway (scatter profile_wexp plot_wexp, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue)), ///
xlabel(0(5)40,labsize(medium)) ylabel(0(1)3,labsize(medium)) 		/// 
xtitle("Potential Experience",size(medsmall)) ytitle("")	///
title("Experience Effects",size(medlarge) color(black)) name(expeff, replace) xsize(14) ysize(10)

** Cohort 
// normalize 1920 to 1. It's the third row.
gen coh_1920 = profile_coh[3]
replace profile_coh = profile_coh/coh_1920

replace plot_coh = plot_coh + 2.5 // This is the shift the point to the middle of the bins.

twoway (scatter profile_coh plot_coh, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue)), ///
xlabel(1910(10)1990,labsize(medsmall)) ylabel(0(1)4,labsize(medsmall)) 		/// 
xtitle("Birth Year",size(medsmall)) ytitle("")	///
title("Cohort Effects (Cohort bin 1920-1924 = 1)",size(medlarge) color(black)) name(coheff, replace) xsize(14) ysize(10)

** Time 
* Normalizing.  Set 1969 to 1. It's the 8th row.
gen F_per_time = profile_year[8]
replace profile_year = profile_year/F_per_time


twoway (scatter profile_year plot_year, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue)), ///
xlabel(1965(5)2020,labsize(medsmall)) ylabel(0(2)20,labsize(medsmall)) 		/// 
xtitle("Year",size(medsmall)) ytitle("")	///
title("Time Effects (Year 1969 = 1)",size(medlarge) color(black)) name(yeareff, replace) xsize(14) ysize(10)

** Combine and export 
graph combine expeff coheff yeareff, xsize(12) ysize(22) row(3) 
graph export "Figs\Fig4_HLT_ConstrainedReg.jpg", replace