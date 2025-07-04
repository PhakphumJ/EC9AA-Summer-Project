** This do-file is for cleaning CPI data

clear
cd "/home/phakphum/WarwickPhD/EC9AA Summer Project/Data"
* Extract only the year
import delimited "CWSR0000SA0_NBD20150101.csv"
gen year = substr(observation_date ,1,4)
destring year, replace

* Divide the index by 100 
gen CPI = cwsr0000sa0_nbd20150101/100

* Save as a new file
keep year CPI
drop if CPI == .
save "CPI_WageEarner_1947_to_2024_cleaned.dta", replace
