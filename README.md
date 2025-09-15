# Explainations of the Codes for Decomposing Wages into Experience, Cohort, and Time Effects
1. The coder should begin with cleaning the CPI data, as this will be used later on to create real wages variables when cleaning the CPS and the US Census. The code for this task is: 
*"CPI_U_SAdj_Prep.do"* and *"CPI_U_SU_Prep.do"* which are for cleaning the CPI-U dataset downloaded from the FRED website. The first one is for the seasonally adjusted CPI-U, the second one is for the **unadjusted** series (but it's a longer series).

2. Then use 
  - *"CPS_DataPrep_Initial.do"* to clean the CPS the way I did initially (subtract 1 from both *age* and *year*, define the outlier flag differently from Fang and Qiu (2023).) 
  - *"CPS_DataPrep.do"* to create CPS dataset that use the same way to create the outlier flag as Fang and Qiu (2023). This do-file creates two versions of CPS. First, with uncorrected age. Second, with corrected age.
  - *"US Census Prep.do"* to clean the US Census. This do-file use the same way to create the outlier flag as Fang and Qiu (2023). This do-file creates two versions of US Census. First, with uncorrected age. Second, with corrected age.
  
3. Use the do-files *"My_and_their_algo_on_initial_data.do"* and *"My_and_their_algo_on_FinalClean_data.do"*. These will run my algorithm and Fang and Qiu (2023)'s algorithm on the CPS datasets created in Step 2. 
To plot the results, use *"Plotting Fig4_Init_and_Paper.do"* and *"Plotting Fig4_FinalClean_and_Paper.do"*. These two do-files also compare the results with the results from the Fang and Qiu (2023) (their Figure 4).

4. Use *"Decomposition_Baseline_SampleX.do"* to perform the decompostion on Sample X (1, 2, or 3). This implements the baseline specification. 

5.  Use *"AlternativeSpecificationSqCube.do"* to perform the decompostion on Sample 1, 2, and 3. This implements the alternative specification with the approach inspired by Card, Heining, and Kline (2013). 

6. To plot the results from Step 4 and 5, Use *"Plotting_Fig4_3Samples_Baseline_AltSpec.do"*.

7. Use *"HLT_AltSpec_Cubic_SampleX.do"* and *"HLT_AltSpec_Quartic_SampleX.do"* to perform the decomposiion using polynomials in potential experience while still using the Deaton-Hall approach. Plot the results by using *"Plotting_Fig4_3Samples_Alt_Poly.do"*.

(Optional) *"Constrained_Regression_HLT.do"* is for implementing the HLT approach by using a constrained regression instead of the iterative procedure. 