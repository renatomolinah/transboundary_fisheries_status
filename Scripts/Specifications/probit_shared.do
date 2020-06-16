clear all

* Set up script sctructure, load dataset, and set up working space;

#delimit ;
set more off;

use "~/WDB.dta";


* Set up panel structure;

xtset id year; 

gen y = 0;

replace y = 1 if bio < 1;

gen space = fao;

gen clust = space;	

////Threshold at 0%////;

* Create covariates;

gen x = shared0;
gen hs = hs0;

* Create a common label for all tables;

label variable x "Shared";	

* Run specification regressions;

eststo shared0_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared0_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo shared0_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared0_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo shared0_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo shared0_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared0_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared0_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";		

* Create output table;	
	
esttab shared0_1 shared0_2 shared0_3 shared0_4 
			shared0_5 shared0_6 shared0_7 shared0_8 
	using "probit_spec_shared_bio_0.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 0_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("ll Log-likelihood");	
	
////Threshold at 5%////;	
	
* Create covariates;

replace x = shared5;
replace hs = hs5;

* Run specification regressions;

eststo shared5_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared5_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo shared5_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared5_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo shared5_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo shared5_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared5_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared5_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
* Create output table;

esttab shared5_1 shared5_2 shared5_3 shared5_4 
			shared5_5 shared5_6 shared5_7 shared5_8 
	using "probit_spec_shared_bio_5.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 5_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("ll Log-likelihood");

////Threshold at 10%////;	
	
* Create covariates;	
	
replace x = shared10;
replace hs = hs10;

* Run specification regressions;

eststo shared10_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared10_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo shared10_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared10_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo shared10_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo shared10_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared10_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared10_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";		

* Create output table;	
	
esttab shared10_1 shared10_2 shared10_3 shared10_4 
			shared10_5 shared10_6 shared10_7 shared10_8
	using "probit_spec_shared_bio_10.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 10_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("ll Log-likelihood");
	
////Threshold at 15%////;
	
* Create covariates;
	
replace x = shared15;
replace hs = hs15;

* Run specification regressions;

eststo shared15_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared15_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo shared15_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared15_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo shared15_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo shared15_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared15_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared15_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
* Create ouput table;

esttab shared15_1 shared15_2 shared15_3 shared15_4 
			shared15_5 shared15_6 shared15_7 shared15_8
	using "probit_spec_shared_bio_15.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 15_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("ll Log-likelihood");

////Threshold at 20%////;	
	
* Create covariates;	
	
replace x = shared20;
replace hs = hs20;

* Run specification regressions;

eststo shared20_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared20_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo shared20_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared20_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo shared20_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo shared20_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared20_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared20_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
* Create output table;

esttab shared20_1 shared20_2 shared20_3 shared20_4 
			shared20_5 shared20_6 shared20_7 shared20_8
	using "probit_spec_shared_bio_20.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 20_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("ll Log-likelihood");

////Threshold at 25%////;	
	
* Create covariates;	
	
replace x = shared25;
replace hs = hs25;

* Run regressions;

eststo shared25_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared25_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo shared25_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo shared25_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo shared25_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo shared25_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared25_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo shared25_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";		

* Create output table;	
	
esttab shared25_1 shared25_2 shared25_3 shared25_4 
			shared25_5 shared25_6 shared25_7 shared25_8
	using "probit_spec_shared_bio_25.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 25_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("ll Log-likelihood");
	
esttab shared0_8 shared5_8 shared10_8 shared15_8 shared20_8 shared25_8,
	keep(x); 
