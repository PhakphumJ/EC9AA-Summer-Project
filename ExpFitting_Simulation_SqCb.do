clear
cd "/home/phakphum/WarwickPhD/EC9AA Summer Project"

clear      
set obs 40  
gen exp = _n - 1 // (0-39)
gen true_fn = 1+ log(1+exp) // assume this is the true experience profile.
gen log_true_fn = log(true_fn)

*** Now we will fit beta_1(exp - exp_bar)^2 + beta_2(exp - exp_bar)^3 to the the true function.
gen exp_bar = 35 // zero effects at exp_bar 
gen exp_sq = (exp - exp_bar)^2
gen exp_cube = (exp - exp_bar)^3

reg log_true_fn exp_sq exp_cube
mat coef_mat=e(b)
gen exp_sq_eff = coef_mat[1,1]
gen exp_cb_eff = coef_mat[1,2]
predict y_hat
gen level_fitted = exp(y_hat)

// We fitted fit the function to the true effects in log. But plot the results in level. 

** Plot the result
twoway (scatter true_fn exp, msymbol(dh) mcolor(blue) msize(small) connect(l) lcolor(blue))		/// 
(scatter level_fitted exp, msymbol(dh) mcolor(red) msize(small) connect(l) lcolor(red)) ///  
(scatter log_true_fn exp, msymbol(th) mcolor(blue) msize(small) connect(l) lcolor(blue) lpattern(dash))		/// 
(scatter y_hat exp, msymbol(th) mcolor(red) msize(small) connect(l) lcolor(red) lpattern(dash)), ///  
xlabel(0(5)40,labsize(medium)) ylabel(1(1)4,labsize(medium)) 		/// 
xtitle("Potential Experience",size(medsmall)) ytitle("")	///
legend(order(1 "True Values (level)" 2 "Fitted Values (level)" 3 "True Values (log)" 4 "Fitted Values (log)") rows(2) pos(6) size(medsmall))	///
title("Experience Effects",size(medlarge) color(black)) name(expeff_sim, replace) xsize(14) ysize(10)

** Save the results
graph export "Figs/exp_sim_fit.jpg", name(expeff_sim) replace
