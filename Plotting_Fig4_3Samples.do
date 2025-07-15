***** This do-file is for plotting the results of the composition. *****
**** Of the three samples ****
* (i) CPS 1961 - 2023
* (ii) US Census 1969 - 2022
* (iii) CPS 1961 - 2023 (using only the years available in the US Census).

/// Let's start with the baseline specification ///

**** First we need to prepare data for plotting ****
// Sample 1
clear
cd "/home/phakphum/WarwickPhD/EC9AA Summer Project"

use "Data/Temp/HLT_results_sample1_UnCr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_basel_UnCr
}
save "Data/Temp/HLT_results_sample1_UnCr_profile.dta", replace


clear
use "Data/Temp/HLT_results_sample1_Cr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_basel_Cr
}
save "Data/Temp/HLT_results_sample1_Cr_profile.dta", replace

// Sample 2
clear
use "Data/Temp/HLT_results_sample2_UnCr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_basel_UnCr
}
save "Data/Temp/HLT_results_sample2_UnCr_profile.dta", replace


clear
use "Data/Temp/HLT_results_sample2_Cr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_basel_Cr
}
save "Data/Temp/HLT_results_sample2_Cr_profile.dta", replace


// Sample 3
clear
use "Data/Temp/HLT_results_sample3_UnCr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_basel_UnCr
}
save "Data/Temp/HLT_results_sample3_UnCr_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample3_Cr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_basel_Cr
}
save "Data/Temp/HLT_results_sample3_Cr_profile.dta", replace

*** Then, we merge the datasets.
** Experience dataset 
clear
use "Data/Temp/HLT_results_sample1_UnCr_profile.dta"
keep plot_wexp profile_wexp_sam1_basel_UnCr
drop if profile_wexp_sam1_basel_UnCr == .
save "Data/Temp/HLT_results_sample1_UnCr_exp_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample1_Cr_profile.dta"
keep plot_wexp profile_wexp_sam1_basel_Cr
drop if profile_wexp_sam1_basel_Cr == .
save "Data/Temp/HLT_results_sample1_Cr_exp_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample2_UnCr_profile.dta"
keep plot_wexp profile_wexp_sam2_basel_UnCr
drop if profile_wexp_sam2_basel_UnCr == .
save "Data/Temp/HLT_results_sample2_UnCr_exp_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample2_Cr_profile.dta"
keep plot_wexp profile_wexp_sam2_basel_Cr
drop if profile_wexp_sam2_basel_Cr == .
save "Data/Temp/HLT_results_sample2_Cr_exp_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample3_UnCr_profile.dta"
keep plot_wexp profile_wexp_sam3_basel_UnCr
drop if profile_wexp_sam3_basel_UnCr == .
save "Data/Temp/HLT_results_sample3_UnCr_exp_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample3_Cr_profile.dta"
keep plot_wexp profile_wexp_sam3_basel_Cr
drop if profile_wexp_sam3_basel_Cr == .
save "Data/Temp/HLT_results_sample3_Cr_exp_profile.dta", replace


clear
use "Data/Temp/HLT_results_sample1_UnCr_exp_profile.dta" 
merge 1:1 plot_wexp using "Data/Temp/HLT_results_sample1_Cr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data/Temp/HLT_results_sample2_UnCr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data/Temp/HLT_results_sample2_Cr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data/Temp/HLT_results_sample3_UnCr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data/Temp/HLT_results_sample3_Cr_exp_profile.dta", nogenerate keepusing(profile_wexp*)


save "Data/Temp/HLT_results_all_sample_exp_profile.dta", replace

** Cohort dataset
clear
use "Data/Temp/HLT_results_sample1_UnCr_profile.dta"
keep plot_coh profile_coh_sam1_basel_UnCr
drop if profile_coh_sam1_basel_UnCr == .
save "Data/Temp/HLT_results_sample1_UnCr_coh_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample1_Cr_profile.dta"
keep plot_coh profile_coh_sam1_basel_Cr
drop if profile_coh_sam1_basel_Cr == .
save "Data/Temp/HLT_results_sample1_Cr_coh_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample2_UnCr_profile.dta"
keep plot_coh profile_coh_sam2_basel_UnCr
drop if profile_coh_sam2_basel_UnCr == .
save "Data/Temp/HLT_results_sample2_UnCr_coh_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample2_Cr_profile.dta"
keep plot_coh profile_coh_sam2_basel_Cr
drop if profile_coh_sam2_basel_Cr == .
save "Data/Temp/HLT_results_sample2_Cr_coh_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample3_UnCr_profile.dta"
keep plot_coh profile_coh_sam3_basel_UnCr
drop if profile_coh_sam3_basel_UnCr == .
save "Data/Temp/HLT_results_sample3_UnCr_coh_profile.dta", replace

clear
use "Data/Temp/HLT_results_sample3_Cr_profile.dta"
keep plot_coh profile_coh_sam3_basel_Cr
drop if profile_coh_sam3_basel_Cr == .
save "Data/Temp/HLT_results_sample3_Cr_coh_profile.dta", replace


clear
use "Data/Temp/HLT_results_sample1_UnCr_coh_profile.dta" 
merge 1:1 plot_coh using "Data/Temp/HLT_results_sample1_Cr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data/Temp/HLT_results_sample2_UnCr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data/Temp/HLT_results_sample2_Cr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data/Temp/HLT_results_sample3_UnCr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data/Temp/HLT_results_sample3_Cr_coh_profile.dta", nogenerate keepusing(profile_coh*)


save "Data/Temp/HLT_results_all_sample_cohort_profile.dta", replace

** Time dataset
clear
use "Data/Temp/HLT_results_sample1_UnCr_profile.dta"
keep plot_year profile_year_sam1_basel_UnCr
merge 1:1 plot_year using "Data/Temp/HLT_results_sample1_Cr_profile.dta", nogenerate keepusing(profile_year*)
merge 1:1 plot_year using "Data/Temp/HLT_results_sample2_UnCr_profile.dta", nogenerate keepusing(profile_year*)
merge 1:1 plot_year using "Data/Temp/HLT_results_sample2_Cr_profile.dta", nogenerate keepusing(profile_year*)
merge 1:1 plot_year using "Data/Temp/HLT_results_sample3_UnCr_profile.dta", nogenerate keepusing(profile_year*)
merge 1:1 plot_year using "Data/Temp/HLT_results_sample3_Cr_profile.dta", nogenerate keepusing(profile_year*)

save "Data/Temp/HLT_results_all_sample_time_profile.dta", replace


*** Plotting. ***
** Experience **
clear
use "Data/Temp/HLT_results_all_sample_exp_profile.dta"


twoway (scatter profile_wexp_sam1_basel_UnCr plot_wexp, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_wexp_sam1_basel_Cr plot_wexp, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_wexp_sam2_basel_UnCr plot_wexp, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_wexp_sam2_basel_Cr plot_wexp, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_wexp_sam3_basel_UnCr plot_wexp, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_wexp_sam3_basel_Cr plot_wexp, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(0(5)40,labsize(medium)) ylabel(1(1)4,labsize(medium)) 		/// 
xtitle("wexp",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Experience Effects (1969 = 1)",size(medlarge) color(black)) name(expeff_baseline, replace) xsize(14) ysize(10)

** Cohort **



** Time ** 
* Normalizing.  Set 1969 to 1. It's the 8th row.
clear
use "Data/Temp/HLT_results_all_sample_time_profile.dta"

gen F_per_time_sample1_UnCr = profile_year_sam1_basel_UnCr[8]
gen F_per_time_sample1_Cr = profile_year_sam1_basel_Cr[8]
gen F_per_time_sample2_UnCr = profile_year_sam2_basel_UnCr[8]
gen F_per_time_sample2_Cr = profile_year_sam2_basel_Cr[8]
gen F_per_time_sample3_UnCr = profile_year_sam3_basel_UnCr[8]
gen F_per_time_sample3_Cr = profile_year_sam3_basel_Cr[8]

replace profile_year_sam1_basel_UnCr = profile_year_sam1_basel_UnCr/F_per_time_sample1_UnCr
replace profile_year_sam1_basel_Cr = profile_year_sam1_basel_Cr/F_per_time_sample1_Cr
replace profile_year_sam2_basel_UnCr = profile_year_sam2_basel_UnCr/F_per_time_sample2_UnCr
replace profile_year_sam2_basel_Cr = profile_year_sam2_basel_Cr/F_per_time_sample2_Cr
replace profile_year_sam3_basel_UnCr = profile_year_sam3_basel_UnCr/F_per_time_sample3_UnCr
replace profile_year_sam3_basel_Cr = profile_year_sam3_basel_Cr/F_per_time_sample3_Cr


twoway (scatter profile_year_sam1_basel_UnCr plot_year, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_year_sam1_basel_Cr plot_year, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_year_sam2_basel_UnCr plot_year, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_year_sam2_basel_Cr plot_year, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_year_sam3_basel_UnCr plot_year, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_year_sam3_basel_Cr plot_year, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(1965(5)2020,labsize(medsmall)) ylabel(1(0.5)2,labsize(medsmall)) 		/// 
xtitle("Year",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Time Effects (1969 = 1)",size(medlarge) color(black)) name(yeareff_baseline, replace) xsize(14) ysize(10)


/// Alternative Specification ///

**** First we need to prepare data for plotting ****
// Sample 1
clear
cd "/home/phakphum/WarwickPhD/EC9AA Summer Project"

use "Data/Temp/AltSpec_sample1_UnCr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_altsp_UnCr
}

replace plot_year = . if profile_year == .
save "Data/Temp/AltSpec_results_sample1_UnCr_profile.dta", replace


clear
use "Data/Temp/AltSpec_sample1_Cr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_altsp_Cr
}
save "Data/Temp/AltSpec_results_sample1_Cr_profile.dta", replace

// Sample 2
clear
use "Data/Temp/AltSpec_sample2_UnCr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_altsp_UnCr
}
save "Data/Temp/AltSpec_results_sample2_UnCr_profile.dta", replace


clear
use "Data/Temp/AltSpec_sample2_Cr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_altsp_Cr
}
save "Data/Temp/AltSpec_results_sample2_Cr_profile.dta", replace

// Sample 3
clear
use "Data/Temp/AltSpec_sample3_UnCr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_altsp_UnCr
}
save "Data/Temp/AltSpec_results_sample3_UnCr_profile.dta", replace


clear
use "Data/Temp/AltSpec_sample3_Cr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_altsp_Cr
}
save "Data/Temp/AltSpec_results_sample3_Cr_profile.dta", replace

*** Then, we merge the datasets.
clear
use "Data/Temp/AltSpec_results_sample1_UnCr_profile.dta"
merge 1:1 plot_year plot_wexp plot_coh using "Data/Temp/AltSpec_results_sample1_Cr_profile.dta", nogenerate 
merge 1:1 plot_year plot_wexp plot_coh using "Data/Temp/AltSpec_results_sample2_UnCr_profile.dta", nogenerate 
merge 1:1 plot_year plot_wexp plot_coh using "Data/Temp/AltSpec_results_sample2_Cr_profile.dta", nogenerate 
merge 1:1 plot_year plot_wexp plot_coh using "Data/Temp/AltSpec_results_sample3_UnCr_profile.dta", nogenerate 
merge 1:1 plot_year plot_wexp plot_coh using "Data/Temp/AltSpec_results_sample3_Cr_profile.dta", nogenerate 
sort plot_year


*** Normalizing.


*** Plotting.
