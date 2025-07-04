*** This is for trying to reverse engineer how to create outlier flag. *** 

clear
cd "/home/phakphum/WarwickPhD/EC9AA Summer Project/Replication Package"
use "data/US.dta"

* create outlier flag
// Calculate the 2.5th and 97.5th percentile income for each year
gen double income_bottom2_5pct = . 
gen double income_top2_5pct = .

levelsof year, local(years_list) // Stores unique years in a local macro called 'years_list'
foreach y of local years_list {
    display "Processing year: `y'" 
    
    // Calculate 2.5th and 97.5th percentiles for the current year
    _pctile earnings if year == `y', percentiles(2.5 97.5)
    
    local p2_5 = r(r1)
    local p97_5 = r(r2)
	
	// Display the calculated percentiles
    display "  {txt}2.5th Percentile: {res}`p2_5'"
    display "  {txt}97.5th Percentile: {res}`p97_5'"
    
    // Generate the flags for the current year
    
    replace income_bottom2_5pct = (earnings < `p2_5') if year == `y' & earnings != .
    

    replace income_top2_5pct = (earnings > `p97_5') if year == `y'	& earnings != .
}

// Generate the outlier flag
gen outlier_2 = income_bottom2_5pct + income_top2_5pct

** Evaluate the accuracy
corr outlier outlier_2
