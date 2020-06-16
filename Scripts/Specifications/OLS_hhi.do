clear all

* Set up script sctructure, load dataset, and set up working space;

#delimit ;
set more off;

use "~/WDB.dta";




* Set up panel structure;

xtset id year;

gen y = bio;

gen space = fao;

gen clust = space;	

////Threshold at 0%////;

* Create covariates;

gen x = hhi0;
gen hs = hs0;

* Create a common label for all tables;

label variable x "HHI";	

* Run specification regressions;

eststo hhi0_1:quietly xtreg y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi0_2:quietly xtreg y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo hhi0_3:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi0_4:quietly xtreg y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo hhi0_5:quietly xtreg y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo hhi0_6:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi0_7:quietly xtreg y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi0_8:quietly xtreg y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";		

* Create output table;	
	
esttab hhi0_1 hhi0_2 hhi0_3 hhi0_4 
			hhi0_5 hhi0_6 hhi0_7 hhi0_8 
	using "spec_hhi_bio_0.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 0_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o R~^2~");	
	
////Threshold at 5%////;	
	
* Create covariates;

replace x = hhi5;
replace hs = hs5;

* Run specification regressions;

eststo hhi5_1:quietly xtreg y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi5_2:quietly xtreg y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo hhi5_3:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi5_4:quietly xtreg y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo hhi5_5:quietly xtreg y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo hhi5_6:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi5_7:quietly xtreg y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi5_8:quietly xtreg y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
* Create output table;

esttab hhi5_1 hhi5_2 hhi5_3 hhi5_4 
			hhi5_5 hhi5_6 hhi5_7 hhi5_8 
	using "spec_hhi_bio_5.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 5_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o R~^2~");

////Threshold at 10%////;	
	
* Create covariates;	
	
replace x = hhi10;
replace hs = hs10;

* Run specification regressions;

eststo hhi10_1:quietly xtreg y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi10_2:quietly xtreg y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo hhi10_3:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi10_4:quietly xtreg y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo hhi10_5:quietly xtreg y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo hhi10_6:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi10_7:quietly xtreg y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi10_8:quietly xtreg y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";		

* Create output table;	
	
esttab hhi10_1 hhi10_2 hhi10_3 hhi10_4 
			hhi10_5 hhi10_6 hhi10_7 hhi10_8
	using "spec_hhi_bio_10.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 10_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o R~^2~");
	
////Threshold at 15%////;
	
* Create covariates;
	
replace x = hhi15;
replace hs = hs15;

* Run specification regressions;

eststo hhi15_1:quietly xtreg y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi15_2:quietly xtreg y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo hhi15_3:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi15_4:quietly xtreg y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo hhi15_5:quietly xtreg y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo hhi15_6:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi15_7:quietly xtreg y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi15_8:quietly xtreg y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
* Create ouput table;

esttab hhi15_1 hhi15_2 hhi15_3 hhi15_4 
			hhi15_5 hhi15_6 hhi15_7 hhi15_8
	using "spec_hhi_bio_15.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 15_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o R~^2~");

////Threshold at 20%////;	
	
* Create covariates;	
	
replace x = hhi20;
replace hs = hs20;

* Run specification regressions;

eststo hhi20_1:quietly xtreg y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi20_2:quietly xtreg y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo hhi20_3:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi20_4:quietly xtreg y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo hhi20_5:quietly xtreg y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo hhi20_6:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi20_7:quietly xtreg y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi20_8:quietly xtreg y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
* Create output table;

esttab hhi20_1 hhi20_2 hhi20_3 hhi20_4 
			hhi20_5 hhi20_6 hhi20_7 hhi20_8
	using "spec_hhi_bio_20.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 20_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o R~^2~");

////Threshold at 25%////;	
	
* Create covariates;	
	
replace x = hhi25;
replace hs = hs25;

* Run regressions;

eststo hhi25_1:quietly xtreg y x hs
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi25_2:quietly xtreg y x hs
	age max i.cate  
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = " ";
	estadd local spacefe = " ";
	estadd local yearfe = "X";
	
eststo hhi25_3:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = " ";
	estadd local manafe = "X";
	estadd local spacefe = " ";
	estadd local yearfe = "X";

eststo hhi25_4:quietly xtreg y x hs
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";
	
eststo hhi25_5:quietly xtreg y x hs
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "";
	estadd local yearfe = "X";
	
eststo hhi25_6:quietly xtreg y x hs 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi25_7:quietly xtreg y x hs
	age max i.cate 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "";
	estadd local spacefe = "X";
	estadd local yearfe = "X";	
	
eststo hhi25_8:quietly xtreg y x hs 
	age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space#i.year
	, vce(cluster clust);
	estadd local bioco = "X";
	estadd local manafe = "X";
	estadd local spacefe = "X";
	estadd local yearfe = "X";		

* Create output table;	
	
esttab hhi25_1 hhi25_2 hhi25_3 hhi25_4 
			hhi25_5 hhi25_6 hhi25_7 hhi25_8
	using "spec_hhi_bio_25.tex"	, replace keep(*x) drop(*max)
	compress se(%3.2f) b(2) label obslast
	substitute(~  $ _# \%)
	mgroups("~B/B_{MSY}~ with Threshold at 25_#",
		pattern(1)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o R~^2~");	
