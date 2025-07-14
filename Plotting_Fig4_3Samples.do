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
clear
use "Data/Temp/HLT_results_sample1_UnCr_profile.dta"
merge 1:1 plot_year using "Data/Temp/HLT_results_sample1_Cr_profile.dta", nogenerate 
merge 1:1 plot_year using "Data/Temp/HLT_results_sample2_UnCr_profile.dta", nogenerate 
merge 1:1 plot_year using "Data/Temp/HLT_results_sample2_Cr_profile.dta", nogenerate 
merge 1:1 plot_year using "Data/Temp/HLT_results_sample3_UnCr_profile.dta", nogenerate 
merge 1:1 plot_year using "Data/Temp/HLT_results_sample3_Cr_profile.dta", nogenerate 
sort plot_year

*** Normalizing.


*** Plotting.




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
merge 1:1 plot_year plot_wexp using "Data/Temp/AltSpec_results_sample1_Cr_profile.dta", nogenerate 
merge 1:1 plot_year plot_wexp using "Data/Temp/AltSpec_results_sample2_UnCr_profile.dta", nogenerate 
merge 1:1 plot_year plot_wexp using "Data/Temp/AltSpec_results_sample2_Cr_profile.dta", nogenerate 
merge 1:1 plot_year plot_wexp using "Data/Temp/AltSpec_results_sample3_UnCr_profile.dta", nogenerate 
merge 1:1 plot_year plot_wexp using "Data/Temp/AltSpec_results_sample3_Cr_profile.dta", nogenerate 
sort plot_year


*** Normalizing.


*** Plotting.
