***** This do-file is for plotting the results of the composition. *****

*** First, I would like to compare the results of the decomposition using
* (i) the original dataset and the original algorithm from the replication packgage
* (ii) the dataset I cleaned myself and the original algorithm
* (iii) the dataset I cleaned myself and the algorithm I coded
** The data are from 1986 - 2012.

** Merge the three datasets containing the results. Can do this using plot_year as the key variable. Want to bring in profile_wexp, profile_coh, and profile_year.

clear
cd "E:\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project"

use "E:\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Replication Package\temp\us_HLToutput.dta"

keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year // keep only relevant variables


* have to add suffixes before merging 
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_all_orig
}
save "Data\Temp\HLT_results_CPS_1986_2012_all_orig_profile.dta", replace
clear

* Do the same with the other two datasets.
use "Data\Temp\HLT_results_CPS_1986_2012_identical_algo.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_self_data_orig_algo
}
save "Data\Temp\HLT_results_CPS_1986_2012_self_data_orig_algo_profile.dta", replace
clear


use "Data\Temp\HLT_results_CPS_1986_2012.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_all_self
}
save "Data\Temp\HLT_results_CPS_1986_2012_all_self_profile.dta", replace
clear


* Merging 
use "Data\Temp\HLT_results_CPS_1986_2012_all_orig_profile.dta"
merge 1:1 plot_year using "Data\Temp\HLT_results_CPS_1986_2012_self_data_orig_algo_profile.dta", keepusing(profile_wexp* profile_coh* profile_year*) nogenerate 
merge 1:1 plot_year using "Data\Temp\HLT_results_CPS_1986_2012_all_self_profile.dta", keepusing(profile_wexp* profile_coh* profile_year*) nogenerate 

*** Plotting ***
** Experience **

replace plot_wexp = plot_wexp + 2.5 // This is the shift the point to the middle of the bins.

twoway (scatter profile_wexp_all_orig plot_wexp, msymbol(dh) mcolor(blue) msize(large) connect(l) lcolor(blue)) ///
	(scatter profile_wexp_self_data_orig_algo plot_wexp, msymbol(oh) mcolor(red) msize(large) connect(l) lcolor(red)) /// 
	(scatter profile_wexp_all_self plot_wexp, msymbol(th) mcolor(emerald) msize(large) connect(l) lcolor(emerald)),		///
	xlabel(0(5)40,labsize(medium)) ylabel(1(1)4,labsize(medium)) 		/// 
	xtitle("Potential Experience",size(medium)) ytitle("")	///
	legend(order(1 "Results from the paper" 2 "Self-cleaned data with algo from the replication packgage" 3 "Self-cleaned data with self-built algo") rows(3) pos(6) size(medium))	///
	title("Experience Effects",size(large) color(black)) name(exp, replace) xsize(14) ysize(10)

	
** Cohort **

replace plot_coh = plot_coh + 2.5 // This is the shift the point to the middle of the bins.

twoway (scatter profile_coh_all_orig plot_coh, msymbol(dh) mcolor(blue) msize(large) connect(l) lcolor(blue)) ///
	(scatter profile_coh_self_data_orig_algo plot_coh, msymbol(oh) mcolor(red) msize(large) connect(l) lcolor(red)) /// 
	(scatter profile_coh_all_self plot_coh, msymbol(th) mcolor(emerald) msize(large) connect(l) lcolor(emerald)),		///
	xlabel(1935(10)1985,labsize(medium))  xmtick(##2) ylabel(1(0.25)2,labsize(medium)) 		/// 
	xtitle("Birth Year",size(medium)) ytitle("")	///
	legend(order(1 "Results from the paper" 2 "Self-cleaned data with algo from the replication packgage" 3 "Self-cleaned data with self-built algo") rows(3) pos(6) size(medium))	///
	title("Cohort Effects",size(large) color(black)) name(coh, replace) xsize(14) ysize(10)
	
** Time ** 

* For time, has to normalize the effect in the first year to 1 first.

gen F_per_time_all_orig = profile_year_all_orig[1]
gen F_per_time_self_data_orig_algo = profile_year_self_data_orig_algo[1]
gen F_per_time_all_self = profile_year_all_self[1]

replace profile_year_all_orig = profile_year_all_orig/F_per_time_all_orig
replace profile_year_self_data_orig_algo = profile_year_self_data_orig_algo/F_per_time_self_data_orig_algo
replace profile_year_all_self = profile_year_all_self/F_per_time_all_self

twoway (scatter profile_year_all_orig plot_year, msymbol(dh) mcolor(blue) msize(large) connect(l) lcolor(blue)) ///
	(scatter profile_year_self_data_orig_algo plot_year, msymbol(oh) mcolor(red) msize(large) connect(l) lcolor(red)) /// 
	(scatter profile_year_all_self plot_year, msymbol(th) mcolor(emerald) msize(large) connect(l) lcolor(emerald)),		///
	xlabel(1985(5)2010,labsize(medium)) ylabel(1(1)4,labsize(medium)) 		/// 
	xtitle("Year",size(medium)) ytitle("")	///
	legend(order(1 "Results from the paper" 2 "Self-cleaned data with algo from the replication packgage" 3 "Self-cleaned data with self-built algo") rows(3) pos(6) size(medium))	///
	title("Time Effects",size(large) color(black)) name(year, replace) xsize(14) ysize(10)
	
** Exporting the graph
graph export "Figs\exp_fig4_three_outputs.jpg", name(exp) replace
graph export "Figs\coh_fig4_three_outputs.jpg", name(coh) replace
graph export "Figs\year_fig4_three_outputs.jpg", name(year) replace

*** Second, compare the results using all time periods with results using only data from 1986-2012.
clear
use "Data\Temp\HLT_results_CPS_1961_2023.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist * {
    rename `var' `var'_all_period
}
rename plot_year_all_period plot_year
save "Data\Temp\HLT_results_CPS_1961_2023_profile.dta", replace


** Merging
clear
use "Data\Temp\HLT_results_CPS_1986_2012_all_self_profile.dta"
merge 1:1 plot_year using "Data\Temp\HLT_results_CPS_1961_2023_profile.dta", nogenerate 
sort plot_year
* To compare have to normalize. Cohort Effects of 1935 to be 1. Time Effects of 1986 to be 1. Experience effects need no further normalization. After that we would need to subset the date for plotting.


* Normalizing the cohort effect. 1935 to 1
gen coh_effect_1935_all = profile_coh_all_period[6] // it's in the 6th row.
gen profile_coh_all_period_norm = profile_coh_all_period/coh_effect_1935_all

* Normalizing the time effect. 1986 to 1
gen time_effect_1935_sub = profile_year_all_self[26] // it's in the 26th row.
gen profile_year_self_sub_norm = profile_year_all_self/time_effect_1935_sub
gen time_effect_1935_all = profile_year_all_period[26] // it's in the 26th row.
gen profile_year_all_period_norm = profile_year_all_period/time_effect_1935_all


*** Plotting the comparisons *** 
** Experience **

replace plot_wexp = plot_wexp + 2.5 // This is the shift the point to the middle of the bins.
replace plot_wexp_all_period = plot_wexp_all_period + 2.5 // This is the shift the point to the middle of the bins.


twoway (scatter profile_wexp_all_self plot_wexp, msymbol(th) mcolor(emerald) msize(large) connect(l) lcolor(emerald))		/// 
(scatter profile_wexp_all_period plot_wexp_all_period, msymbol(dh) mcolor(blue) msize(large) connect(l) lcolor(blue)), /// 
xlabel(0(5)40,labsize(medium)) ylabel(1(1)4,labsize(medium)) 		/// 
xtitle("Potential Experience",size(medium)) ytitle("")	///
legend(order(1 "1986-2012" 2 "1961-2023") rows(1) pos(6) size(medium))	///
title("Experience Effects",size(large) color(black)) name(exp2, replace) xsize(14) ysize(10)