* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                   ///
  int     year         1-4      ///
  long    serial       5-9      ///
  byte    month        10-11    ///
  double  hwtfinl      12-21    ///
  double  cpsid        22-35    ///
  byte    asecflag     36-36    ///
  byte    hflag        37-37    ///
  double  asecwth      38-48    ///
  byte    statefip     49-50    ///
  byte    statecensus  51-52    ///
  byte    pernum       53-54    ///
  double  wtfinl       55-68    ///
  double  cpsidp       69-82    ///
  double  cpsidv       83-97    ///
  double  asecwt       98-108   ///
  byte    age          109-110  ///
  byte    sex          111-111  ///
  int     race         112-114  ///
  byte    marst        115-115  ///
  byte    birthqtr     116-116  ///
  byte    qage         117-118  ///
  byte    qmarst       119-120  ///
  byte    qsex         121-122  ///
  byte    qrace        123-124  ///
  byte    empstat      125-126  ///
  byte    labforce     127-127  ///
  int     occ          128-131  ///
  int     ind          132-135  ///
  int     uhrsworkt    136-138  ///
  byte    quhrsworkt   139-140  ///
  byte    qempstat     141-141  ///
  byte    qind         142-142  ///
  byte    qlabforc     143-143  ///
  byte    qocc         144-144  ///
  int     educ         145-147  ///
  byte    qeduc        148-149  ///
  byte    reportyr     150-151  ///
  double  inctot       152-160  ///
  double  incwage      161-168  ///
  double  incbus       169-176  ///
  double  incfarm      177-184  ///
  double  inclongj     185-192  ///
  long    oincbus      193-199  ///
  double  oincfarm     200-207  ///
  double  oincwage     208-215  ///
  byte    qoincbus     216-216  ///
  byte    qoincbusd    217-218  ///
  byte    qoincfarm    219-219  ///
  byte    qoincfarmd   220-221  ///
  byte    qinclong     222-222  ///
  byte    qinclongd    223-224  ///
  byte    qoincwage    225-225  ///
  byte    qoincwaged   226-227  ///
  byte    qincwage     228-228  ///
  byte    tincfarm     229-229  ///
  byte    tinclongj    230-230  ///
  byte    toincbus     231-231  ///
  byte    toincwage    232-232  ///
  using `"cps_00001.dat"'

replace hwtfinl     = hwtfinl     / 10000
replace asecwth     = asecwth     / 10000
replace wtfinl      = wtfinl      / 10000
replace asecwt      = asecwt      / 10000

format hwtfinl     %10.4f
format cpsid       %14.0f
format asecwth     %11.4f
format wtfinl      %14.4f
format cpsidp      %14.0f
format cpsidv      %15.0f
format asecwt      %11.4f
format inctot      %9.0f
format incwage     %8.0f
format incbus      %8.0f
format incfarm     %8.0f
format inclongj    %8.0f
format oincfarm    %8.0f
format oincwage    %8.0f

label var year        `"Survey year"'
label var serial      `"Household serial number"'
label var month       `"Month"'
label var hwtfinl     `"Household weight, Basic Monthly"'
label var cpsid       `"CPSID, household record"'
label var asecflag    `"Flag for ASEC"'
label var hflag       `"Flag for the 3/8 file 2014"'
label var asecwth     `"Annual Social and Economic Supplement Household weight"'
label var statefip    `"State (FIPS code)"'
label var statecensus `"State (Census code)"'
label var pernum      `"Person number in sample unit"'
label var wtfinl      `"Final Basic Weight"'
label var cpsidp      `"CPSID, person record"'
label var cpsidv      `"Validated Longitudinal Identifier"'
label var asecwt      `"Annual Social and Economic Supplement Weight"'
label var age         `"Age"'
label var sex         `"Sex"'
label var race        `"Race"'
label var marst       `"Marital status"'
label var birthqtr    `"Quarter of birth"'
label var qage        `"Data quality flag for AGE"'
label var qmarst      `"Data quality flag for MARST"'
label var qsex        `"Data quality flag for SEX"'
label var qrace       `"Data quality flag for RACE"'
label var empstat     `"Employment status"'
label var labforce    `"Labor force status"'
label var occ         `"Occupation"'
label var ind         `"Industry"'
label var uhrsworkt   `"Hours usually worked per week at all jobs"'
label var quhrsworkt  `"Data quality flag for UHRSWORKT (total hours usually worked)"'
label var qempstat    `"Data quality flag for EMPSTAT"'
label var qind        `"Data quality flag for IND"'
label var qlabforc    `"Data quality flag for LABFORCE"'
label var qocc        `"Data quality flag for OCC"'
label var educ        `"Educational attainment recode"'
label var qeduc       `"Data quality flag for EDUC"'
label var reportyr    `"Reported survey year"'
label var inctot      `"Total personal income"'
label var incwage     `"Wage and salary income"'
label var incbus      `"Non-farm business income"'
label var incfarm     `"Farm income"'
label var inclongj    `"Earnings from longest job"'
label var oincbus     `"Earnings from other work included business self-employment earnings"'
label var oincfarm    `"Earnings from other work included farm self-employment earnings"'
label var oincwage    `"Earnings from other work included wage and salary earnings"'
label var qoincbus    `"Data quality flag for OINCBUS [general version]"'
label var qoincbusd   `"Data quality flag for OINCBUS [detailed version]"'
label var qoincfarm   `"Data quality flag for OINCFARM [general version]"'
label var qoincfarmd  `"Data quality flag for OINCFARM [detailed version]"'
label var qinclong    `"Data quality flag for INCLONGJ [general version]"'
label var qinclongd   `"Data quality flag for INCLONGJ [detailed version]"'
label var qoincwage   `"Data quality flag for OINCWAGE [general version]"'
label var qoincwaged  `"Data quality flag for OINCWAGE [detailed version]"'
label var qincwage    `"Data quality flag for INCWAGE"'
label var tincfarm    `"Topcode Flag for INCFARM"'
label var tinclongj   `"Topcode Flag for INCLONGJ"'
label var toincbus    `"Topcode Flag for OINCBUS"'
label var toincwage   `"Topcode Flag for OINCWAGE"'

label define month_lbl 01 `"January"'
label define month_lbl 02 `"February"', add
label define month_lbl 03 `"March"', add
label define month_lbl 04 `"April"', add
label define month_lbl 05 `"May"', add
label define month_lbl 06 `"June"', add
label define month_lbl 07 `"July"', add
label define month_lbl 08 `"August"', add
label define month_lbl 09 `"September"', add
label define month_lbl 10 `"October"', add
label define month_lbl 11 `"November"', add
label define month_lbl 12 `"December"', add
label values month month_lbl

label define asecflag_lbl 1 `"ASEC"'
label define asecflag_lbl 2 `"March Basic"', add
label values asecflag asecflag_lbl

label define hflag_lbl 0 `"5/8 file"'
label define hflag_lbl 1 `"3/8 file"', add
label values hflag hflag_lbl

label define statefip_lbl 01 `"Alabama"'
label define statefip_lbl 02 `"Alaska"', add
label define statefip_lbl 04 `"Arizona"', add
label define statefip_lbl 05 `"Arkansas"', add
label define statefip_lbl 06 `"California"', add
label define statefip_lbl 08 `"Colorado"', add
label define statefip_lbl 09 `"Connecticut"', add
label define statefip_lbl 10 `"Delaware"', add
label define statefip_lbl 11 `"District of Columbia"', add
label define statefip_lbl 12 `"Florida"', add
label define statefip_lbl 13 `"Georgia"', add
label define statefip_lbl 15 `"Hawaii"', add
label define statefip_lbl 16 `"Idaho"', add
label define statefip_lbl 17 `"Illinois"', add
label define statefip_lbl 18 `"Indiana"', add
label define statefip_lbl 19 `"Iowa"', add
label define statefip_lbl 20 `"Kansas"', add
label define statefip_lbl 21 `"Kentucky"', add
label define statefip_lbl 22 `"Louisiana"', add
label define statefip_lbl 23 `"Maine"', add
label define statefip_lbl 24 `"Maryland"', add
label define statefip_lbl 25 `"Massachusetts"', add
label define statefip_lbl 26 `"Michigan"', add
label define statefip_lbl 27 `"Minnesota"', add
label define statefip_lbl 28 `"Mississippi"', add
label define statefip_lbl 29 `"Missouri"', add
label define statefip_lbl 30 `"Montana"', add
label define statefip_lbl 31 `"Nebraska"', add
label define statefip_lbl 32 `"Nevada"', add
label define statefip_lbl 33 `"New Hampshire"', add
label define statefip_lbl 34 `"New Jersey"', add
label define statefip_lbl 35 `"New Mexico"', add
label define statefip_lbl 36 `"New York"', add
label define statefip_lbl 37 `"North Carolina"', add
label define statefip_lbl 38 `"North Dakota"', add
label define statefip_lbl 39 `"Ohio"', add
label define statefip_lbl 40 `"Oklahoma"', add
label define statefip_lbl 41 `"Oregon"', add
label define statefip_lbl 42 `"Pennsylvania"', add
label define statefip_lbl 44 `"Rhode Island"', add
label define statefip_lbl 45 `"South Carolina"', add
label define statefip_lbl 46 `"South Dakota"', add
label define statefip_lbl 47 `"Tennessee"', add
label define statefip_lbl 48 `"Texas"', add
label define statefip_lbl 49 `"Utah"', add
label define statefip_lbl 50 `"Vermont"', add
label define statefip_lbl 51 `"Virginia"', add
label define statefip_lbl 53 `"Washington"', add
label define statefip_lbl 54 `"West Virginia"', add
label define statefip_lbl 55 `"Wisconsin"', add
label define statefip_lbl 56 `"Wyoming"', add
label define statefip_lbl 61 `"Maine-New Hampshire-Vermont"', add
label define statefip_lbl 65 `"Montana-Idaho-Wyoming"', add
label define statefip_lbl 68 `"Alaska-Hawaii"', add
label define statefip_lbl 69 `"Nebraska-North Dakota-South Dakota"', add
label define statefip_lbl 70 `"Maine-Massachusetts-New Hampshire-Rhode Island-Vermont"', add
label define statefip_lbl 71 `"Michigan-Wisconsin"', add
label define statefip_lbl 72 `"Minnesota-Iowa"', add
label define statefip_lbl 73 `"Nebraska-North Dakota-South Dakota-Kansas"', add
label define statefip_lbl 74 `"Delaware-Virginia"', add
label define statefip_lbl 75 `"North Carolina-South Carolina"', add
label define statefip_lbl 76 `"Alabama-Mississippi"', add
label define statefip_lbl 77 `"Arkansas-Oklahoma"', add
label define statefip_lbl 78 `"Arizona-New Mexico-Colorado"', add
label define statefip_lbl 79 `"Idaho-Wyoming-Utah-Montana-Nevada"', add
label define statefip_lbl 80 `"Alaska-Washington-Hawaii"', add
label define statefip_lbl 81 `"New Hampshire-Maine-Vermont-Rhode Island"', add
label define statefip_lbl 83 `"South Carolina-Georgia"', add
label define statefip_lbl 84 `"Kentucky-Tennessee"', add
label define statefip_lbl 85 `"Arkansas-Louisiana-Oklahoma"', add
label define statefip_lbl 87 `"Iowa-N Dakota-S Dakota-Nebraska-Kansas-Minnesota-Missouri"', add
label define statefip_lbl 88 `"Washington-Oregon-Alaska-Hawaii"', add
label define statefip_lbl 89 `"Montana-Wyoming-Colorado-New Mexico-Utah-Nevada-Arizona"', add
label define statefip_lbl 90 `"Delaware-Maryland-Virginia-West Virginia"', add
label define statefip_lbl 99 `"State not identified"', add
label values statefip statefip_lbl

label define statecensus_lbl 00 `"Unknown"'
label define statecensus_lbl 11 `"Maine"', add
label define statecensus_lbl 12 `"New Hampshire"', add
label define statecensus_lbl 13 `"Vermont"', add
label define statecensus_lbl 14 `"Massachusetts"', add
label define statecensus_lbl 15 `"Rhode Island"', add
label define statecensus_lbl 16 `"Connecticut"', add
label define statecensus_lbl 19 `"Maine, New Hampshire, Vermont, Rhode Island"', add
label define statecensus_lbl 21 `"New York"', add
label define statecensus_lbl 22 `"New Jersey"', add
label define statecensus_lbl 23 `"Pennsylvania"', add
label define statecensus_lbl 31 `"Ohio"', add
label define statecensus_lbl 32 `"Indiana"', add
label define statecensus_lbl 33 `"Illinois"', add
label define statecensus_lbl 34 `"Michigan"', add
label define statecensus_lbl 35 `"Wisconsin"', add
label define statecensus_lbl 39 `"Michigan, Wisconsin"', add
label define statecensus_lbl 41 `"Minnesota"', add
label define statecensus_lbl 42 `"Iowa"', add
label define statecensus_lbl 43 `"Missouri"', add
label define statecensus_lbl 44 `"North Dakota"', add
label define statecensus_lbl 45 `"South Dakota"', add
label define statecensus_lbl 46 `"Nebraska"', add
label define statecensus_lbl 47 `"Kansas"', add
label define statecensus_lbl 49 `"Minnesota, Iowa, Missouri, North Dakota, South Dakota, Nebraska, Kansas"', add
label define statecensus_lbl 50 `"Delaware, Maryland, Virginia, West Virginia"', add
label define statecensus_lbl 51 `"Delaware"', add
label define statecensus_lbl 52 `"Maryland"', add
label define statecensus_lbl 53 `"District of Columbia"', add
label define statecensus_lbl 54 `"Virginia"', add
label define statecensus_lbl 55 `"West Virginia"', add
label define statecensus_lbl 56 `"North Carolina"', add
label define statecensus_lbl 57 `"South Carolina"', add
label define statecensus_lbl 58 `"Georgia"', add
label define statecensus_lbl 59 `"Florida"', add
label define statecensus_lbl 60 `"South Carolina, Georgia"', add
label define statecensus_lbl 61 `"Kentucky"', add
label define statecensus_lbl 62 `"Tennessee"', add
label define statecensus_lbl 63 `"Alabama"', add
label define statecensus_lbl 64 `"Mississippi"', add
label define statecensus_lbl 67 `"Kentucky, Tennessee"', add
label define statecensus_lbl 69 `"Alabama, Mississippi"', add
label define statecensus_lbl 71 `"Arkansas"', add
label define statecensus_lbl 72 `"Louisiana"', add
label define statecensus_lbl 73 `"Oklahoma"', add
label define statecensus_lbl 74 `"Texas"', add
label define statecensus_lbl 79 `"Arkansas, Louisiana, Oklahoma"', add
label define statecensus_lbl 81 `"Montana"', add
label define statecensus_lbl 82 `"Idaho"', add
label define statecensus_lbl 83 `"Wyoming"', add
label define statecensus_lbl 84 `"Colorado"', add
label define statecensus_lbl 85 `"New Mexico"', add
label define statecensus_lbl 86 `"Arizona"', add
label define statecensus_lbl 87 `"Utah"', add
label define statecensus_lbl 88 `"Nevada"', add
label define statecensus_lbl 89 `"Montana, Idaho, Wyoming, Colorado, New Mexico, Arizona, Utah, Nevada"', add
label define statecensus_lbl 91 `"Washington"', add
label define statecensus_lbl 92 `"Oregon"', add
label define statecensus_lbl 93 `"California"', add
label define statecensus_lbl 94 `"Alaska"', add
label define statecensus_lbl 95 `"Hawaii"', add
label define statecensus_lbl 99 `"Washington, Oregon, Alaska, Hawaii"', add
label values statecensus statecensus_lbl

label define age_lbl 00 `"Under 1 year"'
label define age_lbl 01 `"1"', add
label define age_lbl 02 `"2"', add
label define age_lbl 03 `"3"', add
label define age_lbl 04 `"4"', add
label define age_lbl 05 `"5"', add
label define age_lbl 06 `"6"', add
label define age_lbl 07 `"7"', add
label define age_lbl 08 `"8"', add
label define age_lbl 09 `"9"', add
label define age_lbl 10 `"10"', add
label define age_lbl 11 `"11"', add
label define age_lbl 12 `"12"', add
label define age_lbl 13 `"13"', add
label define age_lbl 14 `"14"', add
label define age_lbl 15 `"15"', add
label define age_lbl 16 `"16"', add
label define age_lbl 17 `"17"', add
label define age_lbl 18 `"18"', add
label define age_lbl 19 `"19"', add
label define age_lbl 20 `"20"', add
label define age_lbl 21 `"21"', add
label define age_lbl 22 `"22"', add
label define age_lbl 23 `"23"', add
label define age_lbl 24 `"24"', add
label define age_lbl 25 `"25"', add
label define age_lbl 26 `"26"', add
label define age_lbl 27 `"27"', add
label define age_lbl 28 `"28"', add
label define age_lbl 29 `"29"', add
label define age_lbl 30 `"30"', add
label define age_lbl 31 `"31"', add
label define age_lbl 32 `"32"', add
label define age_lbl 33 `"33"', add
label define age_lbl 34 `"34"', add
label define age_lbl 35 `"35"', add
label define age_lbl 36 `"36"', add
label define age_lbl 37 `"37"', add
label define age_lbl 38 `"38"', add
label define age_lbl 39 `"39"', add
label define age_lbl 40 `"40"', add
label define age_lbl 41 `"41"', add
label define age_lbl 42 `"42"', add
label define age_lbl 43 `"43"', add
label define age_lbl 44 `"44"', add
label define age_lbl 45 `"45"', add
label define age_lbl 46 `"46"', add
label define age_lbl 47 `"47"', add
label define age_lbl 48 `"48"', add
label define age_lbl 49 `"49"', add
label define age_lbl 50 `"50"', add
label define age_lbl 51 `"51"', add
label define age_lbl 52 `"52"', add
label define age_lbl 53 `"53"', add
label define age_lbl 54 `"54"', add
label define age_lbl 55 `"55"', add
label define age_lbl 56 `"56"', add
label define age_lbl 57 `"57"', add
label define age_lbl 58 `"58"', add
label define age_lbl 59 `"59"', add
label define age_lbl 60 `"60"', add
label define age_lbl 61 `"61"', add
label define age_lbl 62 `"62"', add
label define age_lbl 63 `"63"', add
label define age_lbl 64 `"64"', add
label define age_lbl 65 `"65"', add
label define age_lbl 66 `"66"', add
label define age_lbl 67 `"67"', add
label define age_lbl 68 `"68"', add
label define age_lbl 69 `"69"', add
label define age_lbl 70 `"70"', add
label define age_lbl 71 `"71"', add
label define age_lbl 72 `"72"', add
label define age_lbl 73 `"73"', add
label define age_lbl 74 `"74"', add
label define age_lbl 75 `"75"', add
label define age_lbl 76 `"76"', add
label define age_lbl 77 `"77"', add
label define age_lbl 78 `"78"', add
label define age_lbl 79 `"79"', add
label define age_lbl 80 `"80"', add
label define age_lbl 81 `"81"', add
label define age_lbl 82 `"82"', add
label define age_lbl 83 `"83"', add
label define age_lbl 84 `"84"', add
label define age_lbl 85 `"85"', add
label define age_lbl 86 `"86"', add
label define age_lbl 87 `"87"', add
label define age_lbl 88 `"88"', add
label define age_lbl 89 `"89"', add
label define age_lbl 90 `"90 (90+, 1988-2002)"', add
label define age_lbl 91 `"91"', add
label define age_lbl 92 `"92"', add
label define age_lbl 93 `"93"', add
label define age_lbl 94 `"94"', add
label define age_lbl 95 `"95"', add
label define age_lbl 96 `"96"', add
label define age_lbl 97 `"97"', add
label define age_lbl 98 `"98"', add
label define age_lbl 99 `"99+"', add
label values age age_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"NIU"', add
label values sex sex_lbl

label define race_lbl 100 `"White"'
label define race_lbl 200 `"Black"', add
label define race_lbl 300 `"American Indian/Aleut/Eskimo"', add
label define race_lbl 650 `"Asian or Pacific Islander"', add
label define race_lbl 651 `"Asian only"', add
label define race_lbl 652 `"Hawaiian/Pacific Islander only"', add
label define race_lbl 700 `"Other (single) race, n.e.c."', add
label define race_lbl 801 `"White-Black"', add
label define race_lbl 802 `"White-American Indian"', add
label define race_lbl 803 `"White-Asian"', add
label define race_lbl 804 `"White-Hawaiian/Pacific Islander"', add
label define race_lbl 805 `"Black-American Indian"', add
label define race_lbl 806 `"Black-Asian"', add
label define race_lbl 807 `"Black-Hawaiian/Pacific Islander"', add
label define race_lbl 808 `"American Indian-Asian"', add
label define race_lbl 809 `"Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 810 `"White-Black-American Indian"', add
label define race_lbl 811 `"White-Black-Asian"', add
label define race_lbl 812 `"White-American Indian-Asian"', add
label define race_lbl 813 `"White-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 814 `"White-Black-American Indian-Asian"', add
label define race_lbl 815 `"American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 816 `"White-Black--Hawaiian/Pacific Islander"', add
label define race_lbl 817 `"White-American Indian-Hawaiian/Pacific Islander"', add
label define race_lbl 818 `"Black-American Indian-Asian"', add
label define race_lbl 819 `"White-American Indian-Asian-Hawaiian/Pacific Islander"', add
label define race_lbl 820 `"Two or three races, unspecified"', add
label define race_lbl 830 `"Four or five races, unspecified"', add
label define race_lbl 999 `"Blank"', add
label values race race_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label define marst_lbl 7 `"Widowed or Divorced"', add
label define marst_lbl 9 `"NIU"', add
label values marst marst_lbl

label define birthqtr_lbl 1 `"January-February-March"'
label define birthqtr_lbl 2 `"April-May-June"', add
label define birthqtr_lbl 3 `"July-August-September"', add
label define birthqtr_lbl 4 `"October-November-December"', add
label values birthqtr birthqtr_lbl

label define qage_lbl 00 `"No change"'
label define qage_lbl 01 `"Blank to value"', add
label define qage_lbl 02 `"Value to value"', add
label define qage_lbl 03 `"Allocated"', add
label define qage_lbl 04 `"Value to allocated value"', add
label define qage_lbl 05 `"Blank to allocated value"', add
label define qage_lbl 06 `"Don't know to allocated value"', add
label define qage_lbl 07 `"Refused to allocated value"', add
label define qage_lbl 08 `"Blank to longitudinal value"', add
label define qage_lbl 09 `"Don't know to longitudinal value"', add
label define qage_lbl 10 `"Refused to longitudinal value"', add
label values qage qage_lbl

label define qmarst_lbl 00 `"No change"'
label define qmarst_lbl 01 `"Value to blank"', add
label define qmarst_lbl 02 `"Blank to value"', add
label define qmarst_lbl 03 `"Value to value"', add
label define qmarst_lbl 04 `"Allocated"', add
label define qmarst_lbl 05 `"Value to value - no error"', add
label define qmarst_lbl 06 `"Don't know to value"', add
label define qmarst_lbl 07 `"Refused to value"', add
label define qmarst_lbl 08 `"Value to allocated value"', add
label define qmarst_lbl 09 `"Blank to allocated value"', add
label define qmarst_lbl 10 `"Don't know to allocated value"', add
label define qmarst_lbl 11 `"Refused to allocated value"', add
label define qmarst_lbl 12 `"Don't know to blank"', add
label define qmarst_lbl 13 `"Refused to blank"', add
label values qmarst qmarst_lbl

label define qsex_lbl 00 `"No change"'
label define qsex_lbl 01 `"Blank to value"', add
label define qsex_lbl 02 `"Value to value"', add
label define qsex_lbl 03 `"Allocated"', add
label define qsex_lbl 04 `"Don't know to value"', add
label define qsex_lbl 05 `"Refused to value"', add
label define qsex_lbl 06 `"Blank to allocated value"', add
label define qsex_lbl 07 `"Don't know to allocated value"', add
label define qsex_lbl 08 `"Refused to allocated value"', add
label define qsex_lbl 09 `"Blank to longitudinal value"', add
label define qsex_lbl 10 `"Don't know to longitudinal value"', add
label define qsex_lbl 11 `"Refused to longitudinal value"', add
label define qsex_lbl 12 `"Allocated by IPUMS"', add
label values qsex qsex_lbl

label define qrace_lbl 00 `"No change / not allocated"'
label define qrace_lbl 04 `"Allocated-no method specified"', add
label define qrace_lbl 10 `"Value to value"', add
label define qrace_lbl 11 `"Blank to value"', add
label define qrace_lbl 12 `"Don't know to value"', add
label define qrace_lbl 13 `"Refused to value"', add
label define qrace_lbl 20 `"Value to longitudinal value"', add
label define qrace_lbl 21 `"Blank to longitudinal value"', add
label define qrace_lbl 22 `"Don't know to longitudinal value"', add
label define qrace_lbl 23 `"Refused to longitudinal value"', add
label define qrace_lbl 30 `"Value to allocated value long"', add
label define qrace_lbl 31 `"Blank to allocated value long"', add
label define qrace_lbl 32 `"Don't know to allocated value long"', add
label define qrace_lbl 33 `"Refused to allocated value long"', add
label define qrace_lbl 40 `"Value to allocated value"', add
label define qrace_lbl 41 `"Blank to allocated value"', add
label define qrace_lbl 42 `"Don't know to allocated value"', add
label define qrace_lbl 43 `"Refused to allocated value"', add
label define qrace_lbl 50 `"Value to blank"', add
label define qrace_lbl 52 `"Don't know to blank"', add
label define qrace_lbl 53 `"Refused to blank"', add
label values qrace qrace_lbl

label define empstat_lbl 00 `"NIU"'
label define empstat_lbl 01 `"Armed Forces"', add
label define empstat_lbl 10 `"At work"', add
label define empstat_lbl 12 `"Has job, not at work last week"', add
label define empstat_lbl 20 `"Unemployed"', add
label define empstat_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_lbl 22 `"Unemployed, new worker"', add
label define empstat_lbl 30 `"Not in labor force"', add
label define empstat_lbl 31 `"NILF, housework"', add
label define empstat_lbl 32 `"NILF, unable to work"', add
label define empstat_lbl 33 `"NILF, school"', add
label define empstat_lbl 34 `"NILF, other"', add
label define empstat_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_lbl 36 `"NILF, retired"', add
label values empstat empstat_lbl

label define labforce_lbl 0 `"NIU"'
label define labforce_lbl 1 `"No, not in the labor force"', add
label define labforce_lbl 2 `"Yes, in the labor force"', add
label values labforce labforce_lbl

label define uhrsworkt_lbl 997 `"Hours vary"'
label define uhrsworkt_lbl 999 `"NIU"', add
label values uhrsworkt uhrsworkt_lbl

label define quhrsworkt_lbl 00 `"No change or children or armed forces"'
label define quhrsworkt_lbl 10 `"Value to value"', add
label define quhrsworkt_lbl 11 `"Blank to value"', add
label define quhrsworkt_lbl 12 `"Don't know to value"', add
label define quhrsworkt_lbl 13 `"Refused to value"', add
label define quhrsworkt_lbl 20 `"Value to longitudinal value"', add
label define quhrsworkt_lbl 21 `"Blank to longitudinal value"', add
label define quhrsworkt_lbl 22 `"Don't know to longitudinal value"', add
label define quhrsworkt_lbl 23 `"Refused to longitudinal value"', add
label define quhrsworkt_lbl 40 `"Value to allocated value"', add
label define quhrsworkt_lbl 41 `"Blank to allocated value"', add
label define quhrsworkt_lbl 42 `"Don't know to allocated value"', add
label define quhrsworkt_lbl 43 `"Refused to allocated value"', add
label define quhrsworkt_lbl 50 `"Value to blank"', add
label define quhrsworkt_lbl 52 `"Don't know to blank"', add
label values quhrsworkt quhrsworkt_lbl

label define qempstat_lbl 0 `"No change or children or armed forces"'
label define qempstat_lbl 1 `"Value to blank"', add
label define qempstat_lbl 2 `"Blank to value"', add
label define qempstat_lbl 3 `"Value to value"', add
label define qempstat_lbl 4 `"Allocated"', add
label define qempstat_lbl 5 `"Blank to allocated value"', add
label define qempstat_lbl 6 `"Blank to longitudinal value"', add
label values qempstat qempstat_lbl

label define qind_lbl 0 `"No change or children or armed forces"'
label define qind_lbl 1 `"Value to blank"', add
label define qind_lbl 2 `"Blank to value"', add
label define qind_lbl 3 `"Value to value"', add
label define qind_lbl 4 `"Allocated"', add
label define qind_lbl 5 `"Value to allocated value"', add
label define qind_lbl 6 `"Blank to allocated value"', add
label define qind_lbl 7 `"Blank to longitudinal value"', add
label values qind qind_lbl

label define qlabforc_lbl 0 `"No change or children or armed forces"'
label define qlabforc_lbl 1 `"Value to blank"', add
label define qlabforc_lbl 2 `"Blank to value"', add
label define qlabforc_lbl 3 `"Value to value"', add
label define qlabforc_lbl 4 `"Allocated"', add
label define qlabforc_lbl 5 `"Blank to allocated value"', add
label define qlabforc_lbl 6 `"Blank to longitudinal value"', add
label values qlabforc qlabforc_lbl

label define qocc_lbl 0 `"No change or children or armed forces"'
label define qocc_lbl 1 `"Value to blank"', add
label define qocc_lbl 2 `"Blank to value"', add
label define qocc_lbl 3 `"Value to value"', add
label define qocc_lbl 4 `"Allocated"', add
label define qocc_lbl 5 `"Value to allocated value"', add
label define qocc_lbl 6 `"Blank to allocated value"', add
label define qocc_lbl 7 `"Blank to longitudinal value"', add
label values qocc qocc_lbl

label define educ_lbl 000 `"NIU or no schooling"'
label define educ_lbl 001 `"NIU or blank"', add
label define educ_lbl 002 `"None or preschool"', add
label define educ_lbl 010 `"Grades 1, 2, 3, or 4"', add
label define educ_lbl 011 `"Grade 1"', add
label define educ_lbl 012 `"Grade 2"', add
label define educ_lbl 013 `"Grade 3"', add
label define educ_lbl 014 `"Grade 4"', add
label define educ_lbl 020 `"Grades 5 or 6"', add
label define educ_lbl 021 `"Grade 5"', add
label define educ_lbl 022 `"Grade 6"', add
label define educ_lbl 030 `"Grades 7 or 8"', add
label define educ_lbl 031 `"Grade 7"', add
label define educ_lbl 032 `"Grade 8"', add
label define educ_lbl 040 `"Grade 9"', add
label define educ_lbl 050 `"Grade 10"', add
label define educ_lbl 060 `"Grade 11"', add
label define educ_lbl 070 `"Grade 12"', add
label define educ_lbl 071 `"12th grade, no diploma"', add
label define educ_lbl 072 `"12th grade, diploma unclear"', add
label define educ_lbl 073 `"High school diploma or equivalent"', add
label define educ_lbl 080 `"1 year of college"', add
label define educ_lbl 081 `"Some college but no degree"', add
label define educ_lbl 090 `"2 years of college"', add
label define educ_lbl 091 `"Associate's degree, occupational/vocational program"', add
label define educ_lbl 092 `"Associate's degree, academic program"', add
label define educ_lbl 100 `"3 years of college"', add
label define educ_lbl 110 `"4 years of college"', add
label define educ_lbl 111 `"Bachelor's degree"', add
label define educ_lbl 120 `"5+ years of college"', add
label define educ_lbl 121 `"5 years of college"', add
label define educ_lbl 122 `"6+ years of college"', add
label define educ_lbl 123 `"Master's degree"', add
label define educ_lbl 124 `"Professional school degree"', add
label define educ_lbl 125 `"Doctorate degree"', add
label define educ_lbl 999 `"Missing/Unknown"', add
label values educ educ_lbl

label define qeduc_lbl 00 `"No change"'
label define qeduc_lbl 01 `"Allocated"', add
label define qeduc_lbl 02 `"Value to blank"', add
label define qeduc_lbl 03 `"Blank to allocated value"', add
label define qeduc_lbl 04 `"Don't know to allocated value"', add
label define qeduc_lbl 05 `"Refused to allocated value"', add
label define qeduc_lbl 06 `"Blank to longitudinal value"', add
label define qeduc_lbl 07 `"Don't know to longitudinal value"', add
label define qeduc_lbl 08 `"Refused to longitudinal value"', add
label define qeduc_lbl 09 `"Don't know to blank"', add
label define qeduc_lbl 10 `"Refused to blank"', add
label values qeduc qeduc_lbl

label define qoincbus_lbl 0 `"Not allocated"'
label define qoincbus_lbl 1 `"Income amount allocated"', add
label define qoincbus_lbl 2 `"Recipiency type allocated"', add
label define qoincbus_lbl 3 `"Income amount  and recipiency type allocated"', add
label values qoincbus qoincbus_lbl

label define qoincbusd_lbl 00 `"Not allocated"'
label define qoincbusd_lbl 10 `"Income amount allocated"', add
label define qoincbusd_lbl 11 `"Level 1 statistical match (value with ranges)"', add
label define qoincbusd_lbl 12 `"Level 2 statistical match (value with ranges)"', add
label define qoincbusd_lbl 13 `"Level 3 statistical match (value with ranges)"', add
label define qoincbusd_lbl 14 `"Level 101 statistical match (value without ranges, recipiency, _yn)"', add
label define qoincbusd_lbl 15 `"Level 102 statistical match (value without ranges, recipiency, _yn)"', add
label define qoincbusd_lbl 16 `"Level 103 statistical match (value without ranges, recipiency, _yn)"', add
label define qoincbusd_lbl 17 `"Level 104 statistical match (age, sex)"', add
label define qoincbusd_lbl 18 `"Level 105 statistical match (all donors can match to all recipients)"', add
label define qoincbusd_lbl 20 `"Recipiency type allocated"', add
label define qoincbusd_lbl 30 `"Income amount  and recipiency type allocated"', add
label values qoincbusd qoincbusd_lbl

label define qoincfarm_lbl 0 `"Not allocated"'
label define qoincfarm_lbl 1 `"Income amount allocated"', add
label define qoincfarm_lbl 2 `"Recipiency type allocated"', add
label define qoincfarm_lbl 3 `"Income amount  and recipiency type allocated"', add
label values qoincfarm qoincfarm_lbl

label define qoincfarmd_lbl 00 `"Not allocated"'
label define qoincfarmd_lbl 10 `"Income amount allocated"', add
label define qoincfarmd_lbl 11 `"Level 1 statistical match (value with ranges)"', add
label define qoincfarmd_lbl 12 `"Level 2 statistical match (value with ranges)"', add
label define qoincfarmd_lbl 13 `"Level 3 statistical match (value with ranges)"', add
label define qoincfarmd_lbl 14 `"Level 101 statistical match (value without ranges, recipiency, _yn)"', add
label define qoincfarmd_lbl 15 `"Level 102 statistical match (value without ranges, recipiency, _yn)"', add
label define qoincfarmd_lbl 16 `"Level 103 statistical match (value without ranges, recipiency, _yn)"', add
label define qoincfarmd_lbl 17 `"Level 104 statistical match (age, sex)"', add
label define qoincfarmd_lbl 18 `"Level 105 statistical match (all donors can match to all recipients)"', add
label define qoincfarmd_lbl 20 `"Recipiency type allocated"', add
label define qoincfarmd_lbl 30 `"Income amount  and recipiency type allocated"', add
label values qoincfarmd qoincfarmd_lbl

label define qinclong_lbl 0 `"No change"'
label define qinclong_lbl 1 `"Income amount allocated"', add
label define qinclong_lbl 2 `"Income type allocated"', add
label define qinclong_lbl 3 `"Income amount and income type allocated"', add
label values qinclong qinclong_lbl

label define qinclongd_lbl 00 `"No change"'
label define qinclongd_lbl 10 `"Income amount allocated"', add
label define qinclongd_lbl 11 `"Level 1 statistical match (value with ranges)"', add
label define qinclongd_lbl 12 `"Level 2 statistical match (value with ranges)"', add
label define qinclongd_lbl 13 `"Level 3 statistical match (value with ranges)"', add
label define qinclongd_lbl 14 `"Level 101 statistical match (value without ranges, recipiency, _yn)"', add
label define qinclongd_lbl 15 `"Level 102 statistical match (value without ranges, recipiency, _yn)"', add
label define qinclongd_lbl 16 `"Level 103 statistical match (value without ranges, recipiency, _yn)"', add
label define qinclongd_lbl 17 `"Level 104 statistical match (age, sex)"', add
label define qinclongd_lbl 18 `"Level 105 statistical match (all donors can match to all recipients)"', add
label define qinclongd_lbl 20 `"Income type allocated"', add
label define qinclongd_lbl 30 `"Income amount and income type allocated"', add
label values qinclongd qinclongd_lbl

label define qoincwage_lbl 0 `"No allocation"'
label define qoincwage_lbl 1 `"Income amount allocated"', add
label define qoincwage_lbl 2 `"Recipiency type allocated"', add
label define qoincwage_lbl 3 `"Income amount  and recipiency type allocated"', add
label values qoincwage qoincwage_lbl

label define qoincwaged_lbl 00 `"No allocation"'
label define qoincwaged_lbl 10 `"Income amount allocated"', add
label define qoincwaged_lbl 11 `"Level 1 statistical match (value with ranges)"', add
label define qoincwaged_lbl 12 `"Level 2 statistical match (value with ranges)"', add
label define qoincwaged_lbl 13 `"Level 3 statistical match (value with ranges)"', add
label define qoincwaged_lbl 14 `"Level 101 statistical match (value without ranges, recipiency, _yn)"', add
label define qoincwaged_lbl 15 `"Level 102 statistical match (value without ranges, recipiency, _yn)"', add
label define qoincwaged_lbl 16 `"Level 103 statistical match (value without ranges, recipiency, _yn)"', add
label define qoincwaged_lbl 17 `"Level 104 statistical match (age, sex)"', add
label define qoincwaged_lbl 18 `"Level 105 statistical match (all donors can match to all recipients)"', add
label define qoincwaged_lbl 20 `"Recipiency type allocated"', add
label define qoincwaged_lbl 30 `"Income amount  and recipiency type allocated"', add
label values qoincwaged qoincwaged_lbl

label define qincwage_lbl 0 `"No allocation"'
label define qincwage_lbl 1 `"Income amount allocated"', add
label define qincwage_lbl 2 `"Recipiency type allocated"', add
label define qincwage_lbl 3 `"Income amount  and recipiency type allocated"', add
label values qincwage qincwage_lbl

label define tincfarm_lbl 0 `"Not topcoded"'
label define tincfarm_lbl 1 `"Topcoded"', add
label values tincfarm tincfarm_lbl

label define tinclongj_lbl 0 `"Not topcoded"'
label define tinclongj_lbl 1 `"Topcoded"', add
label values tinclongj tinclongj_lbl

label define toincbus_lbl 0 `"Not topcoded"'
label define toincbus_lbl 1 `"Topcoded"', add
label values toincbus toincbus_lbl

label define toincwage_lbl 0 `"Not topcoded"'
label define toincwage_lbl 1 `"Topcoded"', add
label values toincwage toincwage_lbl


