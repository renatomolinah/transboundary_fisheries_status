clear all

* Set up script sctructure, load dataset, and set up working space;

#delimit ;
set more off;

use "~/WDB_edf.dta";


* Set up panel structure;

xtset id year; 

gen y = 0;

replace y = 1 if bio < 1;

gen space = fao;

gen clust = space;	

////Threshold at 0%////;

* Create covariates;

gen x = leez0;
gen hs = hs0;

* Create a common label for all tables;

label variable x "EEZ";	

* Run specification regressions;

eststo eez0_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez0_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo eez0_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez0_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo eez0_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo eez0_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez0_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez0_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";		

* Create output table;	
	
esttab eez0_1 eez0_2 eez0_3 eez0_4 
			eez0_5 eez0_6 eez0_7 eez0_8 
	using "probit_spec_eez_bio_0.tex"	, replace keep(*x) drop(*max)
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

replace x = leez5;
replace hs = hs5;

* Run specification regressions;

eststo eez5_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez5_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo eez5_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez5_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo eez5_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo eez5_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez5_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez5_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
* Create output table;

esttab eez5_1 eez5_2 eez5_3 eez5_4 
			eez5_5 eez5_6 eez5_7 eez5_8 
	using "probit_spec_eez_bio_5.tex"	, replace keep(*x) drop(*max)
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
	
replace x = leez10;
replace hs = hs10;

* Run specification regressions;

eststo eez10_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez10_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo eez10_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez10_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo eez10_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo eez10_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez10_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez10_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";		

* Create output table;	
	
esttab eez10_1 eez10_2 eez10_3 eez10_4 
			eez10_5 eez10_6 eez10_7 eez10_8
	using "probit_spec_eez_bio_10.tex"	, replace keep(*x) drop(*max)
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
	
replace x = leez15;
replace hs = hs15;

* Run specification regressions;

eststo eez15_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez15_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo eez15_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez15_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo eez15_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo eez15_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez15_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez15_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
* Create ouput table;

esttab eez15_1 eez15_2 eez15_3 eez15_4 
			eez15_5 eez15_6 eez15_7 eez15_8
	using "probit_spec_eez_bio_15.tex"	, replace keep(*x) drop(*max)
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
	
replace x = leez20;
replace hs = hs20;

* Run specification regressions;

eststo eez20_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez20_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo eez20_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez20_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo eez20_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo eez20_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez20_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez20_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
* Create output table;

esttab eez20_1 eez20_2 eez20_3 eez20_4 
			eez20_5 eez20_6 eez20_7 eez20_8
	using "probit_spec_eez_bio_20.tex"	, replace keep(*x) drop(*max)
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
	
replace x = leez25;
replace hs = hs25;

* Run regressions;

eststo eez25_1:quietly xtprobit y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez25_2:quietly xtprobit y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo eez25_3:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo eez25_4:quietly xtprobit y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo eez25_5:quietly xtprobit y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo eez25_6:quietly xtprobit y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez25_7:quietly xtprobit y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo eez25_8:quietly xtprobit y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";		

* Create output table;	
	
esttab eez25_1 eez25_2 eez25_3 eez25_4 
			eez25_5 eez25_6 eez25_7 eez25_8
	using "probit_spec_eez_bio_25.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 25_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("ll Log-likelihood");	
	
esttab eez0_8 eez5_8 eez10_8 eez15_8 eez20_8 eez25_8,
	keep(x); 
