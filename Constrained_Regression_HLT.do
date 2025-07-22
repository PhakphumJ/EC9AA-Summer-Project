*** This is the code for doing the baselinse HLT decomposition *** (for producing figure 4) ***

clear
cd "/home/phakphum/WarwickPhD/EC9AA Summer Project"
use "Data/CPS_Cleaned_UnCr.dta"

*** Let's try to do figure 4 exactly first. Hence, use data from 1986 - 2012. And restrict sample to those born from 1935 - 1984

keep if year >= 1986 & year <= 2012
keep if ybirth >= 1935 & ybirth <= 1984

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

** Create Deaton's time vriables.
* gen time dummy (This is only used for relabelling later on and create Deaton's time dummy)
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

* Normalizing the weights in each year -> mass of 1 in each year. (Is this a proper thing to do?)
rename asecwt perwt
bys year: egen tot_pers =sum(perwt)
replace perwt = perwt/tot_pers			
bys year: egen av_perwt = mean(perwt)

**************** Decomposition **************
constraint 1 d_exp6 = d_exp7
constraint 2 d_exp7 = d_exp8
cnsreg logrealwage d_exp2 d_exp3 d_exp4 d_exp5 d_exp6 d_exp7 d_exp8 i.coh_rlb i.year_rlb [pweight=perwt], constraint(1,2)

esttab using "HLT_constrained_reg_output.tex", replace tex
