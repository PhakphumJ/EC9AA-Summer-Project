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
dis %9.2f profile_wexp_all_orig[_N]
dis %9.2f profile_wexp_self_data_orig_algo[_N]
dis %9.2f profile_wexp_all_self[_N]

replace plot_wexp = plot_wexp + 2.5 // This is the shift the point to the middle of the bins.

twoway (scatter profile_wexp_all_orig plot_wexp, msymbol(dh) mcolor(blue) msize(large) connect(l) lcolor(blue)) ///
	(scatter profile_wexp_self_data_orig_algo plot_wexp, msymbol(oh) mcolor(red) msize(large) connect(l) lcolor(red)) /// 
	(scatter profile_wexp_all_self plot_wexp, msymbol(th) mcolor(emerald) msize(large) connect(l) lcolor(emerald)),		///
	xlabel(0(5)40,labsize(large)) ylabel(1(1)4,labsize(large)) 		/// 
	xtitle("Potential Experience",size(medium)) ytitle("")	///
	legend(order(1 "Results from the paper" 2 "Self-cleaned data with algo from the replication packgage" 3 "Self-cleaned data with self-built algo") rows(3) pos(6) size(medium))	///
	title("Experience Effects",size(large) color(black)) name(exp, replace)

