#delimit ;
clear all;
set more off;

use "/Users/renatomolina/Box Sync/GitHub/transboundary/Empirical analysis/data/WDB_edf.dta";

cd "/Users/renatomolina/Box Sync/GitHub/transboundary/Empirical analysis/Tables/pnas/summary";

gen eez = eez0 ;
gen hs  = hs0;
gen hhi = hhi0;

gen size = shared0;
replace size = nshared0 if eez ==1;

global X size bio fish eez hhi hs;
	
gen leez = log(eez);
gen shared = 0;
replace shared = 1 if eez>1;

gen nregime = "Non-shared";
replace nregime="Shared" if shared==1;

label variable size "\$N\$";
label variable bio "\$B/B_{MSY}\$";
label variable fish "\$F/F_{MSY}\$";
label variable eez "Number of EEZs";
label variable hhi "Herfindahl-Hirschman Index";
label variable hs "High Seas";


estpost sum $X if nregime=="Non-shared";
matrix meanr1=e(mean);
matrix list meanr1;

estpost sum $X if nregime=="Shared";
matrix meanr2=e(mean);
matrix list meanr2;

estpost ttest $X, by(nregime);

estadd matrix meanr1;
estadd matrix meanr2;

esttab using "summary_0.tex", replace nonumber nomtitle noobs label
mgroups("0~", pattern(1 0 0 0 0 0) prefix(\multicolumn{@span}{c}{)
		suffix(}) span erepeat(\cmidrule(lr){@span}))
	cells("meanr1(fmt(3)) meanr2(fmt(3)) b(star fmt(3)) se(fmt(3))") 
	collabels("Mean (Non-shared)" "Mean (Shared)" "Diff." "Std. Error")
	substitute(\$ $ ~ \%)
	star(* 0.05 ** .01 *** 0.001); 
	
eststo clear;
		
replace eez = eez5 ;
replace hs  = hs5;
replace hhi = hhi5;

replace size = shared5;
replace size = nshared5 if eez ==1;
	
replace leez = log(eez);
replace shared = 0;
replace shared = 1 if eez>1;

replace nregime = "Non-shared";
replace nregime="Shared" if shared==1;

estpost sum $X if nregime=="Non-shared";
matrix meanr1=e(mean);
matrix list meanr1;

estpost sum $X if nregime=="Shared";
matrix meanr2=e(mean);
matrix list meanr2;

estpost ttest $X, by(nregime);

estadd matrix meanr1;
estadd matrix meanr2;

esttab using "summary_5.tex", replace nonumber nomtitle noobs label
mgroups("5~", pattern(1 0 0 0 0 0) prefix(\multicolumn{@span}{c}{)
		suffix(}) span erepeat(\cmidrule(lr){@span}))
	cells("meanr1(fmt(3)) meanr2(fmt(3)) b(star fmt(3)) se(fmt(3))") 
	collabels("Mean (Non-shared)" "Mean (Shared)" "Diff." "Std. Error")
	substitute(_$ $ ~ \%)
	star(* 0.05 ** .01 *** 0.001); 
	
	
eststo clear;	

replace eez = eez10 ;
replace hs  = hs10;
replace hhi = hhi10;

replace size = shared10;
replace size = nshared10 if eez ==1;
	
replace leez = log(eez);
replace shared = 0;
replace shared = 1 if eez>1;

replace nregime = "Non-shared";
replace nregime="Shared" if shared==1;

estpost sum $X if nregime=="Non-shared";
matrix meanr1=e(mean);
matrix list meanr1;

estpost sum $X if nregime=="Shared";
matrix meanr2=e(mean);
matrix list meanr2;

estpost ttest $X, by(nregime);

estadd matrix meanr1;
estadd matrix meanr2;

esttab using "summary_10.tex", replace nonumber nomtitle noobs label
mgroups("10~", pattern(1 0 0 0 0 0) prefix(\multicolumn{@span}{c}{)
		suffix(}) span erepeat(\cmidrule(lr){@span}))
	cells("meanr1(fmt(3)) meanr2(fmt(3)) b(star fmt(3)) se(fmt(3))") 
	collabels("Mean (Non-shared)" "Mean (Shared)" "Diff." "Std. Error")
	substitute(_$ $ ~ \%)
	star(* 0.05 ** .01 *** 0.001); 
	
	
eststo clear;


		
replace eez = eez15 ;
replace hs  = hs15;
replace hhi = hhi15;

replace size = shared15;
replace size = nshared15 if eez ==1;
	
replace leez = log(eez);
replace shared = 0;
replace shared = 1 if eez>1;

replace nregime = "Non-shared";
replace nregime="Shared" if shared==1;

estpost sum $X if nregime=="Non-shared";
matrix meanr1=e(mean);
matrix list meanr1;

estpost sum $X if nregime=="Shared";
matrix meanr2=e(mean);
matrix list meanr2;

estpost ttest $X, by(nregime);

estadd matrix meanr1;
estadd matrix meanr2;

esttab using "summary_15.tex", replace nonumber nomtitle noobs label
mgroups("15~", pattern(1 0 0 0 0 0) prefix(\multicolumn{@span}{c}{)
		suffix(}) span erepeat(\cmidrule(lr){@span}))
	cells("meanr1(fmt(3)) meanr2(fmt(3)) b(star fmt(3)) se(fmt(3))") 
	collabels("Mean (Non-shared)" "Mean (Shared)" "Diff." "Std. Error")
	substitute(_$ $ ~ \%)
	star(* 0.05 ** .01 *** 0.001); 
	
	
eststo clear;		
	
	
replace eez = eez20 ;
replace hs  = hs20;
replace hhi = hhi20;

replace size = shared20;
replace size = nshared20 if eez ==1;
	
replace leez = log(eez);
replace shared = 0;
replace shared = 1 if eez>1;

replace nregime = "Non-shared";
replace nregime="Shared" if shared==1;

estpost sum $X if nregime=="Non-shared";
matrix meanr1=e(mean);
matrix list meanr1;

estpost sum $X if nregime=="Shared";
matrix meanr2=e(mean);
matrix list meanr2;

estpost ttest $X, by(nregime);

estadd matrix meanr1;
estadd matrix meanr2;

esttab using "summary_20.tex", replace nonumber nomtitle noobs label
mgroups("20~", pattern(1 0 0 0 0 0) prefix(\multicolumn{@span}{c}{)
		suffix(}) span erepeat(\cmidrule(lr){@span}))
	cells("meanr1(fmt(3)) meanr2(fmt(3)) b(star fmt(3)) se(fmt(3))") 
	collabels("Mean (Non-shared)" "Mean (Shared)" "Diff." "Std. Error")
	substitute(_$ $ ~ \%)
	star(* 0.05 ** .01 *** 0.001); 
	
	
eststo clear;	


replace eez = eez25 ;
replace hs  = hs25;
replace hhi = hhi25;

replace size = shared25;
replace size = nshared25 if eez ==1;
	
replace leez = log(eez);
replace shared = 0;
replace shared = 1 if eez>1;

replace nregime = "Non-shared";
replace nregime="Shared" if shared==1;

estpost sum $X if nregime=="Non-shared";
matrix meanr1=e(mean);
matrix list meanr1;

estpost sum $X if nregime=="Shared";
matrix meanr2=e(mean);
matrix list meanr2;

estpost ttest $X, by(nregime);

estadd matrix meanr1;
estadd matrix meanr2;

esttab using "summary_25.tex", replace nonumber nomtitle noobs label
mgroups("25~", pattern(1 0 0 0 0 0) prefix(\multicolumn{@span}{c}{)
		suffix(}) span erepeat(\cmidrule(lr){@span}))
	cells("meanr1(fmt(3)) meanr2(fmt(3)) b(star fmt(3)) se(fmt(3))") 
	collabels("Mean (Non-shared)" "Mean (Shared)" "Diff." "Std. Error")
	substitute(_$ $ ~ \%)
	star(* 0.05 ** .01 *** 0.001); 
	
	
eststo clear;		
