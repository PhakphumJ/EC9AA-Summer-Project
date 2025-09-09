***** This do-file is for plotting the results of the composition. *****
**** Of the three samples ****
* (i) CPS 1961 - 2023
* (ii) US Census 1969 - 2022
* (iii) CPS 1961 - 2023 (using only the years available in the US Census).

/// Let's start with the baseline specification ///

**** First we need to prepare data for plotting ****
// Sample 1
clear
cd "C:\Users\fphak\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project"

use "Data\Temp\HLT_results_sample1_UnCr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_basel_UnCr
}
save "Data\Temp\HLT_results_sample1_UnCr_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample1_Cr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_basel_Cr
}
save "Data\Temp\HLT_results_sample1_Cr_profile.dta", replace

// Sample 2
clear
use "Data\Temp\HLT_results_sample2_UnCr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_basel_UnCr
}
save "Data\Temp\HLT_results_sample2_UnCr_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample2_Cr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_basel_Cr
}
save "Data\Temp\HLT_results_sample2_Cr_profile.dta", replace


// Sample 3
clear
use "Data\Temp\HLT_results_sample3_UnCr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_basel_UnCr
}
save "Data\Temp\HLT_results_sample3_UnCr_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample3_Cr.dta"
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_basel_Cr
}
save "Data\Temp\HLT_results_sample3_Cr_profile.dta", replace

*** Then, we merge the datasets.
** Experience dataset 
clear
use "Data\Temp\HLT_results_sample1_UnCr_profile.dta"
keep plot_wexp profile_wexp_sam1_basel_UnCr
drop if profile_wexp_sam1_basel_UnCr == .
save "Data\Temp\HLT_results_sample1_UnCr_exp_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample1_Cr_profile.dta"
keep plot_wexp profile_wexp_sam1_basel_Cr
drop if profile_wexp_sam1_basel_Cr == .
save "Data\Temp\HLT_results_sample1_Cr_exp_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample2_UnCr_profile.dta"
keep plot_wexp profile_wexp_sam2_basel_UnCr
drop if profile_wexp_sam2_basel_UnCr == .
save "Data\Temp\HLT_results_sample2_UnCr_exp_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample2_Cr_profile.dta"
keep plot_wexp profile_wexp_sam2_basel_Cr
drop if profile_wexp_sam2_basel_Cr == .
save "Data\Temp\HLT_results_sample2_Cr_exp_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample3_UnCr_profile.dta"
keep plot_wexp profile_wexp_sam3_basel_UnCr
drop if profile_wexp_sam3_basel_UnCr == .
save "Data\Temp\HLT_results_sample3_UnCr_exp_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample3_Cr_profile.dta"
keep plot_wexp profile_wexp_sam3_basel_Cr
drop if profile_wexp_sam3_basel_Cr == .
save "Data\Temp\HLT_results_sample3_Cr_exp_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample1_UnCr_exp_profile.dta" 
merge 1:1 plot_wexp using "Data\Temp\HLT_results_sample1_Cr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\HLT_results_sample2_UnCr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\HLT_results_sample2_Cr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\HLT_results_sample3_UnCr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\HLT_results_sample3_Cr_exp_profile.dta", nogenerate keepusing(profile_wexp*)


save "Data\Temp\HLT_results_all_sample_exp_profile.dta", replace

** Cohort dataset
clear
use "Data\Temp\HLT_results_sample1_UnCr_profile.dta"
keep plot_coh profile_coh_sam1_basel_UnCr
drop if profile_coh_sam1_basel_UnCr == .
save "Data\Temp\HLT_results_sample1_UnCr_coh_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample1_Cr_profile.dta"
keep plot_coh profile_coh_sam1_basel_Cr
drop if profile_coh_sam1_basel_Cr == .
save "Data\Temp\HLT_results_sample1_Cr_coh_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample2_UnCr_profile.dta"
keep plot_coh profile_coh_sam2_basel_UnCr
drop if profile_coh_sam2_basel_UnCr == .
save "Data\Temp\HLT_results_sample2_UnCr_coh_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample2_Cr_profile.dta"
keep plot_coh profile_coh_sam2_basel_Cr
drop if profile_coh_sam2_basel_Cr == .
save "Data\Temp\HLT_results_sample2_Cr_coh_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample3_UnCr_profile.dta"
keep plot_coh profile_coh_sam3_basel_UnCr
drop if profile_coh_sam3_basel_UnCr == .
save "Data\Temp\HLT_results_sample3_UnCr_coh_profile.dta", replace

clear
use "Data\Temp\HLT_results_sample3_Cr_profile.dta"
keep plot_coh profile_coh_sam3_basel_Cr
drop if profile_coh_sam3_basel_Cr == .
save "Data\Temp\HLT_results_sample3_Cr_coh_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample1_UnCr_coh_profile.dta" 
merge 1:1 plot_coh using "Data\Temp\HLT_results_sample1_Cr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\HLT_results_sample2_UnCr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\HLT_results_sample2_Cr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\HLT_results_sample3_UnCr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\HLT_results_sample3_Cr_coh_profile.dta", nogenerate keepusing(profile_coh*)


save "Data\Temp\HLT_results_all_sample_cohort_profile.dta", replace

** Time dataset
clear
use "Data\Temp\HLT_results_sample1_UnCr_profile.dta"
keep plot_year profile_year_sam1_basel_UnCr
merge 1:1 plot_year using "Data\Temp\HLT_results_sample1_Cr_profile.dta", nogenerate keepusing(profile_year*)
merge 1:1 plot_year using "Data\Temp\HLT_results_sample2_UnCr_profile.dta", nogenerate keepusing(profile_year*)
merge 1:1 plot_year using "Data\Temp\HLT_results_sample2_Cr_profile.dta", nogenerate keepusing(profile_year*)
merge 1:1 plot_year using "Data\Temp\HLT_results_sample3_UnCr_profile.dta", nogenerate keepusing(profile_year*)
merge 1:1 plot_year using "Data\Temp\HLT_results_sample3_Cr_profile.dta", nogenerate keepusing(profile_year*)

save "Data\Temp\HLT_results_all_sample_time_profile.dta", replace


*** Plotting. ***
** Experience **
clear
use "Data\Temp\HLT_results_all_sample_exp_profile.dta"

replace plot_wexp = plot_wexp + 2.5 // This is the shift the point to the middle of the bins.
twoway (scatter profile_wexp_sam1_basel_UnCr plot_wexp, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_wexp_sam1_basel_Cr plot_wexp, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_wexp_sam2_basel_UnCr plot_wexp, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_wexp_sam2_basel_Cr plot_wexp, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_wexp_sam3_basel_UnCr plot_wexp, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_wexp_sam3_basel_Cr plot_wexp, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(0(5)40,labsize(medium)) ylabel(1(1)4,labsize(medium)) 		/// 
xtitle("Potential Experience",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Experience Effects",size(medlarge) color(black)) name(expeff_baseline, replace) xsize(14) ysize(10)

** Cohort **
clear
use "Data\Temp\HLT_results_all_sample_cohort_profile.dta"
// normalize 1920 to 1. It's the third row.
gen coh_1920_sample1_UnCr = profile_coh_sam1_basel_UnCr[3]
gen coh_1920_sample1_Cr = profile_coh_sam1_basel_Cr[3]

replace profile_coh_sam1_basel_UnCr = profile_coh_sam1_basel_UnCr/coh_1920_sample1_UnCr
replace profile_coh_sam1_basel_Cr = profile_coh_sam1_basel_Cr/coh_1920_sample1_Cr

replace plot_coh = plot_coh + 2.5 // This is the shift the point to the middle of the bins.
twoway (scatter profile_coh_sam1_basel_UnCr plot_coh, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_coh_sam1_basel_Cr plot_coh, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_coh_sam2_basel_UnCr plot_coh, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_coh_sam2_basel_Cr plot_coh, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_coh_sam3_basel_UnCr plot_coh, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_coh_sam3_basel_Cr plot_coh, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(1910(10)1990,labsize(medsmall)) ylabel(0(1)4,labsize(medsmall)) 		/// 
xtitle("Birth Year",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Cohort Effects (Cohort bin 1920-1924 = 1)",size(medlarge) color(black)) name(coheff_baseline, replace) xsize(14) ysize(10)


** Time ** 
* Normalizing.  Set 1969 to 1. It's the 8th row.
clear
use "Data\Temp\HLT_results_all_sample_time_profile.dta"

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
xlabel(1965(5)2020,labsize(medsmall)) ylabel(0(0.5)2,labsize(medsmall)) 		/// 
xtitle("Year",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Time Effects (Year 1969 = 1)",size(medlarge) color(black)) name(yeareff_baseline, replace) xsize(14) ysize(10)


** Combine and export 
graph export "Figs\exp_3Samples_Baseline.jpg", name(expeff_baseline) replace
graph export "Figs\coh_3Samples_Baseline.jpg", name(coheff_baseline) replace
graph export "Figs\year_3Samples_Baseline.jpg", name(yeareff_baseline) replace


graph combine expeff_baseline coheff_baseline yeareff_baseline, xsize(12) ysize(22) row(3) 
graph export "Figs\Fig4_3Samples_Baseline.jpg", replace

/////////////////////////////////
/// Alternative Specification ///

**** First we need to prepare data for plotting ****
// Sample 1
clear
cd "C:\Users\fphak\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project"

use "Data\Temp\AltSpec_sample1_UnCr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_altsp_UnCr
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample1_UnCr_profile.dta", replace


clear
use "Data\Temp\AltSpec_sample1_Cr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_altsp_Cr
}
save "Data\Temp\AltSpec_results_sample1_Cr_profile.dta", replace

// Sample 2
clear
use "Data\Temp\AltSpec_sample2_UnCr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_altsp_UnCr
}
save "Data\Temp\AltSpec_results_sample2_UnCr_profile.dta", replace


clear
use "Data\Temp\AltSpec_sample2_Cr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_altsp_Cr
}
save "Data\Temp\AltSpec_results_sample2_Cr_profile.dta", replace

// Sample 3
clear
use "Data\Temp\AltSpec_sample3_UnCr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_altsp_UnCr
}
save "Data\Temp\AltSpec_results_sample3_UnCr_profile.dta", replace


clear
use "Data\Temp\AltSpec_sample3_Cr.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_altsp_Cr
}
save "Data\Temp\AltSpec_results_sample3_Cr_profile.dta", replace

*** Then, we merge the datasets.

** Experience dataset 
clear
use "Data\Temp\AltSpec_results_sample1_UnCr_profile.dta"
keep plot_wexp profile_wexp_sam1_altsp_UnCr
drop if profile_wexp_sam1_altsp_UnCr == .
save "Data\Temp\AltSpec_results_sample1_UnCr_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample1_Cr_profile.dta"
keep plot_wexp profile_wexp_sam1_altsp_Cr
drop if profile_wexp_sam1_altsp_Cr == .
save "Data\Temp\AltSpec_results_sample1_Cr_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample2_UnCr_profile.dta"
keep plot_wexp profile_wexp_sam2_altsp_UnCr
drop if profile_wexp_sam2_altsp_UnCr == .
save "Data\Temp\AltSpec_results_sample2_UnCr_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample2_Cr_profile.dta"
keep plot_wexp profile_wexp_sam2_altsp_Cr
drop if profile_wexp_sam2_altsp_Cr == .
save "Data\Temp\AltSpec_results_sample2_Cr_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample3_UnCr_profile.dta"
keep plot_wexp profile_wexp_sam3_altsp_UnCr
drop if profile_wexp_sam3_altsp_UnCr == .
save "Data\Temp\AltSpec_results_sample3_UnCr_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample3_Cr_profile.dta"
keep plot_wexp profile_wexp_sam3_altsp_Cr
drop if profile_wexp_sam3_altsp_Cr == .
save "Data\Temp\AltSpec_results_sample3_Cr_exp_profile.dta", replace


clear
use "Data\Temp\AltSpec_results_sample1_UnCr_exp_profile.dta" 
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample1_Cr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample2_UnCr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample2_Cr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample3_UnCr_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample3_Cr_exp_profile.dta", nogenerate keepusing(profile_wexp*)


save "Data\Temp\AltSpec_results_all_sample_exp_profile.dta", replace

** Cohort dataset
clear
use "Data\Temp\AltSpec_results_sample1_UnCr_profile.dta"
keep plot_coh profile_coh_sam1_altsp_UnCr
drop if profile_coh_sam1_altsp_UnCr == .
save "Data\Temp\AltSpec_results_sample1_UnCr_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample1_Cr_profile.dta"
keep plot_coh profile_coh_sam1_altsp_Cr
drop if profile_coh_sam1_altsp_Cr == .
save "Data\Temp\AltSpec_results_sample1_Cr_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample2_UnCr_profile.dta"
keep plot_coh profile_coh_sam2_altsp_UnCr
drop if profile_coh_sam2_altsp_UnCr == .
save "Data\Temp\AltSpec_results_sample2_UnCr_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample2_Cr_profile.dta"
keep plot_coh profile_coh_sam2_altsp_Cr
drop if profile_coh_sam2_altsp_Cr == .
save "Data\Temp\AltSpec_results_sample2_Cr_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample3_UnCr_profile.dta"
keep plot_coh profile_coh_sam3_altsp_UnCr
drop if profile_coh_sam3_altsp_UnCr == .
save "Data\Temp\AltSpec_results_sample3_UnCr_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample3_Cr_profile.dta"
keep plot_coh profile_coh_sam3_altsp_Cr
drop if profile_coh_sam3_altsp_Cr == .
save "Data\Temp\AltSpec_results_sample3_Cr_coh_profile.dta", replace


clear
use "Data\Temp\AltSpec_results_sample1_UnCr_coh_profile.dta" 
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample1_Cr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample2_UnCr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample2_Cr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample3_UnCr_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample3_Cr_coh_profile.dta", nogenerate keepusing(profile_coh*)


save "Data\Temp\AltSpec_results_all_sample_cohort_profile.dta", replace

** Time dataset
clear
use "Data\Temp\AltSpec_results_sample1_UnCr_profile.dta"
keep plot_year profile_year_sam1_altsp_UnCr
merge 1:1 plot_year using "Data\Temp\AltSpec_results_sample1_Cr_profile.dta", nogenerate keepusing(profile_year*)
merge 1:m plot_year using "Data\Temp\AltSpec_results_sample2_UnCr_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample2_Cr_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample3_UnCr_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample3_Cr_profile.dta", nogenerate keepusing(profile_year*)

save "Data\Temp\AltSpec_results_all_sample_time_profile.dta", replace


*** Plotting. ***
** Experience **
clear
use "Data\Temp\AltSpec_results_all_sample_exp_profile.dta"

twoway (scatter profile_wexp_sam1_altsp_UnCr plot_wexp, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_wexp_sam1_altsp_Cr plot_wexp, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_wexp_sam2_altsp_UnCr plot_wexp, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_wexp_sam2_altsp_Cr plot_wexp, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_wexp_sam3_altsp_UnCr plot_wexp, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_wexp_sam3_altsp_Cr plot_wexp, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(0(5)40,labsize(medium)) ylabel(1(1)5,labsize(medium)) 		/// 
xtitle("Potential Experience",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Experience Effects",size(medlarge) color(black)) name(expeff_altspec, replace) xsize(14) ysize(10)

** Cohort **
clear
use "Data\Temp\AltSpec_results_all_sample_cohort_profile.dta"
// normalize 1920 to 1. It's the third row.
gen coh_1920_sample1_UnCr = profile_coh_sam1_altsp_UnCr[3]
gen coh_1920_sample1_Cr = profile_coh_sam1_altsp_Cr[3]

replace profile_coh_sam1_altsp_UnCr = profile_coh_sam1_altsp_UnCr/coh_1920_sample1_UnCr
replace profile_coh_sam1_altsp_Cr = profile_coh_sam1_altsp_Cr/coh_1920_sample1_Cr

replace plot_coh = plot_coh + 2.5 // This is the shift the point to the middle of the bins.
twoway (scatter profile_coh_sam1_altsp_UnCr plot_coh, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_coh_sam1_altsp_Cr plot_coh, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_coh_sam2_altsp_UnCr plot_coh, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_coh_sam2_altsp_Cr plot_coh, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_coh_sam3_altsp_UnCr plot_coh, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_coh_sam3_altsp_Cr plot_coh, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(1910(10)1990,labsize(medsmall)) ylabel(0(0.5)2,labsize(medsmall)) 		/// 
xtitle("Birth Year",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Cohort Effects (Cohort bin 1920-1924 = 1)",size(medlarge) color(black)) name(coheff_altspec, replace) xsize(14) ysize(10)


** Time ** 
* Normalizing.  Set 1969 to 1. It's the 8th row.
clear
use "Data\Temp\AltSpec_results_all_sample_time_profile.dta"

gen F_per_time_sample1_UnCr = profile_year_sam1_altsp_UnCr[8]
gen F_per_time_sample1_Cr = profile_year_sam1_altsp_Cr[8]
gen F_per_time_sample2_UnCr = profile_year_sam2_altsp_UnCr[8]
gen F_per_time_sample2_Cr = profile_year_sam2_altsp_Cr[8]
gen F_per_time_sample3_UnCr = profile_year_sam3_altsp_UnCr[8]
gen F_per_time_sample3_Cr = profile_year_sam3_altsp_Cr[8]

replace profile_year_sam1_altsp_UnCr = profile_year_sam1_altsp_UnCr/F_per_time_sample1_UnCr
replace profile_year_sam1_altsp_Cr = profile_year_sam1_altsp_Cr/F_per_time_sample1_Cr
replace profile_year_sam2_altsp_UnCr = profile_year_sam2_altsp_UnCr/F_per_time_sample2_UnCr
replace profile_year_sam2_altsp_Cr = profile_year_sam2_altsp_Cr/F_per_time_sample2_Cr
replace profile_year_sam3_altsp_UnCr = profile_year_sam3_altsp_UnCr/F_per_time_sample3_UnCr
replace profile_year_sam3_altsp_Cr = profile_year_sam3_altsp_Cr/F_per_time_sample3_Cr


twoway (scatter profile_year_sam1_altsp_UnCr plot_year, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_year_sam1_altsp_Cr plot_year, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_year_sam2_altsp_UnCr plot_year, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_year_sam2_altsp_Cr plot_year, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_year_sam3_altsp_UnCr plot_year, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_year_sam3_altsp_Cr plot_year, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(1965(5)2020,labsize(medsmall)) ylabel(0(5)40,labsize(medsmall)) 		/// 
xtitle("Year",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Time Effects (Year 1969 = 1)",size(medlarge) color(black)) name(yeareff_altspec, replace) xsize(14) ysize(10)


** Combine and export 
graph export "Figs\exp_3Samples_altspec.jpg", name(expeff_altspec) replace
graph export "Figs\coh_3Samples_altspec.jpg", name(coheff_altspec) replace
graph export "Figs\year_3Samples_altspec.jpg", name(yeareff_altspec) replace


graph combine expeff_altspec coheff_altspec yeareff_altspec, xsize(12) ysize(22) row(3) 
graph export "Figs\Fig4_3Samples_altspec.jpg", replace
