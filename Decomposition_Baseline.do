*** This is the code for doing the baselinse HLT decomposition *** (for producing figure 4)

clear
cd "E:\OneDrive - University of Warwick\Warwick PhD\Academic\EC9AA Summer Project\Data"
use "CPS_Cleaned.dta"

** Let's try to do figure 4 exactly first. Hence, use data from 1986 - 2012. And restrict sample to those born from 1935 - 1984

keep if year >= 1986 & year <= 2012
keep if ybirth >= 1935 & ybirth <= 1984