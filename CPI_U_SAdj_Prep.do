** This do-file is for cleaning CPI data, the CPI-U seasonally adjusted from 1947 to 2024 obtained from FRED ** 

clear
cd "C:\Users\fphak\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Data"
* Extract only the year, not the dates or months.
import delimited "CPIAUCSL_NBD20150101_1947_to_2024.csv"
gen year = substr(observation_date ,1,4)
destring year, replace

* Divide the index by 100 
gen CPI = cpiaucsl_nbd20150101/100

* Save as a new file
keep year CPI
drop if CPI == .
save "CPI_1947_to_2024_cleaned.dta", replace
