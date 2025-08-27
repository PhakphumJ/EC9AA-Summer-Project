***** This do-file is for plotting the results of the composition. *****
**** Of the three samples ****
* (i) CPS 1961 - 2023
* (ii) US Census 1969 - 2022
* (iii) CPS 1961 - 2023 (using only the years available in the US Census).

/////////////////////////////////
/// Alternative Specification (Deaton-Hall with polynomials in potential experience) ///

**** First we need to prepare data for plotting ****
/// Sample 1
clear
cd "C:\Users\fphak\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project"

// Cubic
use "Data\Temp\HLT_results_sample1_UnCr_AltSpec_cubic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_UnCr_cubic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample1_UnCr_cubic_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample1_Cr_AltSpec_cubic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_Cr_cubic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample1_Cr_cubic_profile.dta", replace

// Quartic

use "Data\Temp\HLT_results_sample1_UnCr_AltSpec_quartic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_UnCr_quartic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample1_UnCr_quartic_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample1_Cr_AltSpec_quartic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam1_Cr_quartic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample1_Cr_quartic_profile.dta", replace

/// Sample 2
// Cubic
clear
use "Data\Temp\HLT_results_sample2_UnCr_AltSpec_cubic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_UnCr_cubic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample2_UnCr_cubic_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample2_Cr_AltSpec_cubic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_Cr_cubic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample2_Cr_cubic_profile.dta", replace

// Quartic

use "Data\Temp\HLT_results_sample2_UnCr_AltSpec_quartic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_UnCr_quartic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample2_UnCr_quartic_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample2_Cr_AltSpec_quartic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam2_Cr_quartic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample2_Cr_quartic_profile.dta", replace

// Sample 3
// Cubic
clear
use "Data\Temp\HLT_results_sample3_UnCr_AltSpec_cubic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_UnCr_cubic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample3_UnCr_cubic_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample3_Cr_AltSpec_cubic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_Cr_cubic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample3_Cr_cubic_profile.dta", replace

// Quartic

use "Data\Temp\HLT_results_sample3_UnCr_AltSpec_quartic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_UnCr_quartic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample3_UnCr_quartic_profile.dta", replace


clear
use "Data\Temp\HLT_results_sample3_Cr_AltSpec_quartic.dta"
replace plot_year = . if profile_year == .
keep profile_wexp plot_wexp profile_coh plot_coh profile_year plot_year
foreach var of varlist profile_wexp profile_coh profile_year {
    rename `var' `var'_sam3_Cr_quartic
}

replace plot_year = . if profile_year == .
save "Data\Temp\AltSpec_results_sample3_Cr_quartic_profile.dta", replace


*** Then, we merge the datasets.

** Experience dataset 
/// Sample 1
// Cubic
clear
use "Data\Temp\AltSpec_results_sample1_UnCr_cubic_profile.dta"
keep plot_wexp profile_wexp_sam1_UnCr_cubic
drop if profile_wexp_sam1_UnCr_cubic == .
save "Data\Temp\AltSpec_results_sample1_UnCr_cubic_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample1_Cr_cubic_profile.dta"
keep plot_wexp profile_wexp_sam1_Cr_cubic
drop if profile_wexp_sam1_Cr_cubic == .
save "Data\Temp\AltSpec_results_sample1_Cr_cubic_exp_profile.dta", replace

// Quartic
clear
use "Data\Temp\AltSpec_results_sample1_UnCr_quartic_profile.dta"
keep plot_wexp profile_wexp_sam1_UnCr_quartic
drop if profile_wexp_sam1_UnCr_quartic == .
save "Data\Temp\AltSpec_results_sample1_UnCr_quartic_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample1_Cr_quartic_profile.dta"
keep plot_wexp profile_wexp_sam1_Cr_quartic
drop if profile_wexp_sam1_Cr_quartic == .
save "Data\Temp\AltSpec_results_sample1_Cr_quartic_exp_profile.dta", replace


/// Sample 2
clear
use "Data\Temp\AltSpec_results_sample2_UnCr_cubic_profile.dta"
keep plot_wexp profile_wexp_sam2_UnCr_cubic
drop if profile_wexp_sam2_UnCr_cubic == .
save "Data\Temp\AltSpec_results_sample2_UnCr_cubic_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample2_Cr_cubic_profile.dta"
keep plot_wexp profile_wexp_sam2_Cr_cubic
drop if profile_wexp_sam2_Cr_cubic == .
save "Data\Temp\AltSpec_results_sample2_Cr_cubic_exp_profile.dta", replace

// Quartic
clear
use "Data\Temp\AltSpec_results_sample2_UnCr_quartic_profile.dta"
keep plot_wexp profile_wexp_sam2_UnCr_quartic
drop if profile_wexp_sam2_UnCr_quartic == .
save "Data\Temp\AltSpec_results_sample2_UnCr_quartic_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample2_Cr_quartic_profile.dta"
keep plot_wexp profile_wexp_sam2_Cr_quartic
drop if profile_wexp_sam2_Cr_quartic == .
save "Data\Temp\AltSpec_results_sample2_Cr_quartic_exp_profile.dta", replace

/// Sample 3

clear
use "Data\Temp\AltSpec_results_sample3_UnCr_cubic_profile.dta"
keep plot_wexp profile_wexp_sam3_UnCr_cubic
drop if profile_wexp_sam3_UnCr_cubic == .
save "Data\Temp\AltSpec_results_sample3_UnCr_cubic_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample3_Cr_cubic_profile.dta"
keep plot_wexp profile_wexp_sam3_Cr_cubic
drop if profile_wexp_sam3_Cr_cubic == .
save "Data\Temp\AltSpec_results_sample3_Cr_cubic_exp_profile.dta", replace

// Quartic
clear
use "Data\Temp\AltSpec_results_sample3_UnCr_quartic_profile.dta"
keep plot_wexp profile_wexp_sam3_UnCr_quartic
drop if profile_wexp_sam3_UnCr_quartic == .
save "Data\Temp\AltSpec_results_sample3_UnCr_quartic_exp_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample3_Cr_quartic_profile.dta"
keep plot_wexp profile_wexp_sam3_Cr_quartic
drop if profile_wexp_sam3_Cr_quartic == .
save "Data\Temp\AltSpec_results_sample3_Cr_quartic_exp_profile.dta", replace



clear
use "Data\Temp\AltSpec_results_sample1_UnCr_cubic_exp_profile.dta" 
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample1_Cr_cubic_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample1_UnCr_quartic_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample1_Cr_quartic_exp_profile.dta", nogenerate keepusing(profile_wexp*)

merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample2_UnCr_cubic_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample2_Cr_cubic_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample2_UnCr_quartic_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample2_Cr_quartic_exp_profile.dta", nogenerate keepusing(profile_wexp*)


merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample3_UnCr_cubic_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample3_Cr_cubic_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample3_UnCr_quartic_exp_profile.dta", nogenerate keepusing(profile_wexp*)
merge 1:1 plot_wexp using "Data\Temp\AltSpec_results_sample3_Cr_quartic_exp_profile.dta", nogenerate keepusing(profile_wexp*)

save "Data\Temp\AltSpec_results_all_sample_exp_profile_all_poly.dta", replace

** Cohort dataset
/// Sample 1
// Cubic
clear
use "Data\Temp\AltSpec_results_sample1_UnCr_cubic_profile.dta"
keep plot_coh profile_coh_sam1_UnCr_cubic
drop if profile_coh_sam1_UnCr_cubic == .
save "Data\Temp\AltSpec_results_sample1_UnCr_cubic_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample1_Cr_cubic_profile.dta"
keep plot_coh profile_coh_sam1_Cr_cubic
drop if profile_coh_sam1_Cr_cubic == .
save "Data\Temp\AltSpec_results_sample1_Cr_cubic_coh_profile.dta", replace

// Quartic
clear
use "Data\Temp\AltSpec_results_sample1_UnCr_quartic_profile.dta"
keep plot_coh profile_coh_sam1_UnCr_quartic
drop if profile_coh_sam1_UnCr_quartic == .
save "Data\Temp\AltSpec_results_sample1_UnCr_quartic_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample1_Cr_quartic_profile.dta"
keep plot_coh profile_coh_sam1_Cr_quartic
drop if profile_coh_sam1_Cr_quartic == .
save "Data\Temp\AltSpec_results_sample1_Cr_quartic_coh_profile.dta", replace


/// Sample 2
clear
use "Data\Temp\AltSpec_results_sample2_UnCr_cubic_profile.dta"
keep plot_coh profile_coh_sam2_UnCr_cubic
drop if profile_coh_sam2_UnCr_cubic == .
save "Data\Temp\AltSpec_results_sample2_UnCr_cubic_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample2_Cr_cubic_profile.dta"
keep plot_coh profile_coh_sam2_Cr_cubic
drop if profile_coh_sam2_Cr_cubic == .
save "Data\Temp\AltSpec_results_sample2_Cr_cubic_coh_profile.dta", replace

// Quartic
clear
use "Data\Temp\AltSpec_results_sample2_UnCr_quartic_profile.dta"
keep plot_coh profile_coh_sam2_UnCr_quartic
drop if profile_coh_sam2_UnCr_quartic == .
save "Data\Temp\AltSpec_results_sample2_UnCr_quartic_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample2_Cr_quartic_profile.dta"
keep plot_coh profile_coh_sam2_Cr_quartic
drop if profile_coh_sam2_Cr_quartic == .
save "Data\Temp\AltSpec_results_sample2_Cr_quartic_coh_profile.dta", replace

/// Sample 3

clear
use "Data\Temp\AltSpec_results_sample3_UnCr_cubic_profile.dta"
keep plot_coh profile_coh_sam3_UnCr_cubic
drop if profile_coh_sam3_UnCr_cubic == .
save "Data\Temp\AltSpec_results_sample3_UnCr_cubic_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample3_Cr_cubic_profile.dta"
keep plot_coh profile_coh_sam3_Cr_cubic
drop if profile_coh_sam3_Cr_cubic == .
save "Data\Temp\AltSpec_results_sample3_Cr_cubic_coh_profile.dta", replace

// Quartic
clear
use "Data\Temp\AltSpec_results_sample3_UnCr_quartic_profile.dta"
keep plot_coh profile_coh_sam3_UnCr_quartic
drop if profile_coh_sam3_UnCr_quartic == .
save "Data\Temp\AltSpec_results_sample3_UnCr_quartic_coh_profile.dta", replace

clear
use "Data\Temp\AltSpec_results_sample3_Cr_quartic_profile.dta"
keep plot_coh profile_coh_sam3_Cr_quartic
drop if profile_coh_sam3_Cr_quartic == .
save "Data\Temp\AltSpec_results_sample3_Cr_quartic_coh_profile.dta", replace



clear
use "Data\Temp\AltSpec_results_sample1_UnCr_cubic_coh_profile.dta" 
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample1_Cr_cubic_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample1_UnCr_quartic_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample1_Cr_quartic_coh_profile.dta", nogenerate keepusing(profile_coh*)

merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample2_UnCr_cubic_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample2_Cr_cubic_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample2_UnCr_quartic_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample2_Cr_quartic_coh_profile.dta", nogenerate keepusing(profile_coh*)


merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample3_UnCr_cubic_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample3_Cr_cubic_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample3_UnCr_quartic_coh_profile.dta", nogenerate keepusing(profile_coh*)
merge 1:1 plot_coh using "Data\Temp\AltSpec_results_sample3_Cr_quartic_coh_profile.dta", nogenerate keepusing(profile_coh*)

save "Data\Temp\AltSpec_results_all_sample_coh_profile_all_poly.dta", replace


** Time dataset
clear
use "Data\Temp\AltSpec_results_sample1_UnCr_cubic_profile.dta"
keep plot_year profile_year_sam1_UnCr

merge 1:1 plot_year using "Data\Temp\AltSpec_results_sample1_Cr_cubic_profile.dta", nogenerate keepusing(profile_year*)
merge 1:m plot_year using "Data\Temp\AltSpec_results_sample1_UnCr_quartic_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample1_Cr_quartic_profile.dta", nogenerate keepusing(profile_year*)

merge m:m plot_year using "Data\Temp\AltSpec_results_sample2_UnCr_cubic_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample2_Cr_cubic_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample2_UnCr_quartic_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample2_Cr_quartic_profile.dta", nogenerate keepusing(profile_year*)

merge m:m plot_year using "Data\Temp\AltSpec_results_sample3_UnCr_cubic_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample3_Cr_cubic_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample3_UnCr_quartic_profile.dta", nogenerate keepusing(profile_year*)
merge m:m plot_year using "Data\Temp\AltSpec_results_sample3_Cr_quartic_profile.dta", nogenerate keepusing(profile_year*)


save "Data\Temp\AltSpec_results_all_sample_time_profile_all_poly.dta", replace


**** Plotting. ****
** Experience **
clear
use "Data\Temp\AltSpec_results_all_sample_exp_profile_all_poly.dta"

*** Cubic ***
twoway (scatter profile_wexp_sam1_UnCr_cubic plot_wexp, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_wexp_sam1_Cr_cubic plot_wexp, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_wexp_sam2_UnCr_cubic plot_wexp, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_wexp_sam2_Cr_cubic plot_wexp, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_wexp_sam3_UnCr_cubic plot_wexp, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_wexp_sam3_Cr_cubic plot_wexp, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(0(5)40,labsize(medium)) ylabel(1(1)5,labsize(medium)) 		/// 
xtitle("Potential Experience",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Experience Effects",size(medlarge) color(black)) name(expeffec_cubic, replace) xsize(14) ysize(10)

*** Quartic ***
twoway (scatter profile_wexp_sam1_UnCr_quartic plot_wexp, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_wexp_sam1_Cr_quartic plot_wexp, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_wexp_sam2_UnCr_quartic plot_wexp, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_wexp_sam2_Cr_quartic plot_wexp, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_wexp_sam3_UnCr_quartic plot_wexp, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_wexp_sam3_Cr_quartic plot_wexp, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(0(5)40,labsize(medium)) ylabel(1(2)15,labsize(medium)) 		/// 
xtitle("Potential Experience",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Experience Effects",size(medlarge) color(black)) name(expeffec_quartic, replace) xsize(14) ysize(10)

** Cohort **
clear
use "Data\Temp\AltSpec_results_all_sample_coh_profile_all_poly.dta"
// normalize 1920 to 1. It's the third row.
gen coh_1920_sam1_UnCr_cubic = profile_coh_sam1_UnCr_cubic[3]
gen coh_1920_sam1_Cr_cubic = profile_coh_sam1_Cr_cubic[3]
gen coh_1920_sam1_UnCr_quartic = profile_coh_sam1_UnCr_quartic[3]
gen coh_1920_sam1_Cr_quartic = profile_coh_sam1_Cr_quartic[3]

replace profile_coh_sam1_UnCr_cubic = profile_coh_sam1_UnCr_cubic/coh_1920_sam1_UnCr_cubic
replace profile_coh_sam1_Cr_cubic = profile_coh_sam1_Cr_cubic/coh_1920_sam1_Cr_cubic
replace profile_coh_sam1_UnCr_quartic = profile_coh_sam1_UnCr_quartic/coh_1920_sam1_UnCr_quartic
replace profile_coh_sam1_Cr_quartic = profile_coh_sam1_Cr_quartic/coh_1920_sam1_Cr_quartic

replace plot_coh = plot_coh + 2.5 // This is the shift the point to the middle of the bins.

*** Cubic ***
twoway (scatter profile_coh_sam1_UnCr_cubic plot_coh, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_coh_sam1_Cr_cubic plot_coh, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_coh_sam2_UnCr_cubic plot_coh, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_coh_sam2_Cr_cubic plot_coh, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_coh_sam3_UnCr_cubic plot_coh, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_coh_sam3_Cr_cubic plot_coh, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(1910(10)1990,labsize(medsmall)) ylabel(0(0.5)2,labsize(medsmall)) 		/// 
xtitle("Birth Year",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Cohort Effects (Cohort bin 1920-1924 = 1)",size(medlarge) color(black)) name(coheffec_cubic, replace) xsize(14) ysize(10)

*** Quartic ***
twoway (scatter profile_coh_sam1_UnCr_quartic plot_coh, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_coh_sam1_Cr_quartic plot_coh, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_coh_sam2_UnCr_quartic plot_coh, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_coh_sam2_Cr_quartic plot_coh, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_coh_sam3_UnCr_quartic plot_coh, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_coh_sam3_Cr_quartic plot_coh, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(1910(10)1990,labsize(medsmall)) ylabel(0(0.5)4,labsize(medsmall)) 		/// 
xtitle("Birth Year",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Cohort Effects (Cohort bin 1920-1924 = 1)",size(medlarge) color(black)) name(coheffec_quartic, replace) xsize(14) ysize(10)

** Time ** 
* Normalizing.  Set 1969 to 1. It's the 8th row.
clear
use "Data\Temp\AltSpec_results_all_sample_time_profile_all_poly.dta"

gen F_per_time_sam1_UnCr_cubic = profile_year_sam1_UnCr_cubic[8]
gen F_per_time_sam1_Cr_cubic = profile_year_sam1_Cr_cubic[8]
gen F_per_time_sam1_UnCr_quartic = profile_year_sam1_UnCr_quartic[8]
gen F_per_time_sam1_Cr_quartic = profile_year_sam1_Cr_quartic[8]

gen F_per_time_sam2_UnCr_cubic = profile_year_sam2_UnCr_cubic[8]
gen F_per_time_sam2_Cr_cubic = profile_year_sam2_Cr_cubic[8]
gen F_per_time_sam2_UnCr_quartic = profile_year_sam2_UnCr_quartic[8]
gen F_per_time_sam2_Cr_quartic = profile_year_sam2_Cr_quartic[8]

gen F_per_time_sam3_UnCr_cubic = profile_year_sam3_UnCr_cubic[8]
gen F_per_time_sam3_Cr_cubic = profile_year_sam3_Cr_cubic[8]
gen F_per_time_sam3_UnCr_quartic = profile_year_sam3_UnCr_quartic[8]
gen F_per_time_sam3_Cr_quartic = profile_year_sam3_Cr_quartic[8]


replace profile_year_sam1_UnCr_cubic = profile_year_sam1_UnCr_cubic/F_per_time_sam1_UnCr_cubic
replace profile_year_sam1_Cr_cubic = profile_year_sam1_Cr_cubic/F_per_time_sam1_Cr_cubic
replace profile_year_sam1_UnCr_quartic = profile_year_sam1_UnCr_quartic/F_per_time_sam1_UnCr_quartic
replace profile_year_sam1_Cr_quartic = profile_year_sam1_Cr_quartic/F_per_time_sam1_Cr_quartic

replace profile_year_sam2_UnCr_cubic = profile_year_sam2_UnCr_cubic/F_per_time_sam2_UnCr_cubic
replace profile_year_sam2_Cr_cubic = profile_year_sam2_Cr_cubic/F_per_time_sam2_Cr_cubic
replace profile_year_sam2_UnCr_quartic = profile_year_sam2_UnCr_quartic/F_per_time_sam2_UnCr_quartic
replace profile_year_sam2_Cr_quartic = profile_year_sam2_Cr_quartic/F_per_time_sam2_Cr_quartic

replace profile_year_sam3_UnCr_cubic = profile_year_sam3_UnCr_cubic/F_per_time_sam3_UnCr_cubic
replace profile_year_sam3_Cr_cubic = profile_year_sam3_Cr_cubic/F_per_time_sam3_Cr_cubic
replace profile_year_sam3_UnCr_quartic = profile_year_sam3_UnCr_quartic/F_per_time_sam3_UnCr_quartic
replace profile_year_sam3_Cr_quartic = profile_year_sam3_Cr_quartic/F_per_time_sam3_Cr_quartic

*** Cubic ***
twoway (scatter profile_year_sam1_UnCr_cubic plot_year, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_year_sam1_Cr_cubic plot_year, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_year_sam2_UnCr_cubic plot_year, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_year_sam2_Cr_cubic plot_year, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_year_sam3_UnCr_cubic plot_year, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_year_sam3_Cr_cubic plot_year, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(1965(5)2020,labsize(medsmall)) ylabel(0(1)4,labsize(medsmall)) 		/// 
xtitle("Year",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Time Effects (Year 1969 = 1)",size(medlarge) color(black)) name(yeareffec_cubic, replace) xsize(14) ysize(10)

*** Quartic ***
twoway (scatter profile_year_sam1_UnCr_quartic plot_year, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter profile_year_sam1_Cr_quartic plot_year, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash)) ///  
(scatter profile_year_sam2_UnCr_quartic plot_year, msymbol(dh) mcolor(emerald) msize(small) connect(l) lcolor(emerald))		/// 
(scatter profile_year_sam2_Cr_quartic plot_year, msymbol(th) mcolor(emerald) msize(small) connect(l) lcolor(emerald) lpattern(dash)) /// 
(scatter profile_year_sam3_UnCr_quartic plot_year, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red))		/// 
(scatter profile_year_sam3_Cr_quartic plot_year, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///
xlabel(1965(5)2020,labsize(medsmall)) ylabel(0(1)4,labsize(medsmall)) 		/// 
xtitle("Year",size(medsmall)) ytitle("")	///
legend(order(1 "Sample 1 Uncorrected age" 2 "Sample 1 Corrected age" 3 "Sample 2 Uncorrected age" 4 "Sample 2 Corrected age" 5 "Sample 3 Uncorrected age" 6 "Sample 3 Corrected age") rows(3) pos(6) size(medsmall))	///
title("Time Effects (Year 1969 = 1)",size(medlarge) color(black)) name(yeareffec_quartic, replace) xsize(14) ysize(10)


** Combine and export 
* Cubic
graph export "Figs\exp_3Samples_cubic.jpg", name(expeffec_cubic) replace
graph export "Figs\coh_3Samples_cubic.jpg", name(coheffec_cubic) replace
graph export "Figs\year_3Samples_cubic.jpg", name(yeareffec_cubic) replace


graph combine expeffec_cubic coheffec_cubic yeareffec_cubic, xsize(12) ysize(22) row(3) 
graph export "Figs\Fig4_3Samples_cubic.jpg", replace

* Quartic
graph export "Figs\exp_3Samples_quartic.jpg", name(expeffec_quartic) replace
graph export "Figs\coh_3Samples_quartic.jpg", name(coheffec_quartic) replace
graph export "Figs\year_3Samples_quartic.jpg", name(yeareffec_quartic) replace


graph combine expeffec_quartic coheffec_quartic yeareffec_quartic, xsize(12) ysize(22) row(3)
graph export "Figs\Fig4_3Samples_quartic.jpg", replace