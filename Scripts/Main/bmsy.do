clear all

* Set up script sctructure, load dataset, and set up working space;

#delimit ;
set more off;

use "~WDB.dta";


* Set up panel structure;

xtset id year;

gen y = bio;

gen space = fao;

gen clust = space;

* Create covariates for threshold of 0%;

gen shared = shared0;
gen leez = leez0;
gen hhi =hhi0;
gen hs = hs0;

* Panel regressions for threshold at 0%;

eststo shared0:quietly xtreg y shared 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year
	, vce(cluster clust);
	
eststo eez0:quietly xtreg y leez 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year
	, vce(cluster clust);
	
eststo hhi0:quietly xtreg y hhi 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);

* Create covariates for threshold of 5%;	
	
replace shared = shared5;
replace leez = leez5;
replace hhi =hhi5;
replace hs = hs5;	

* Panel regressions for threshold at 5%;
	
eststo shared5:quietly xtreg y shared 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	estadd local bioco = "Yes";
	estadd local manafe = "Yes";
	estadd local spacefe = "Yes";
	estadd local yearfe = "Yes";
	
eststo eez5:quietly xtreg y leez 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
eststo hhi5:quietly xtreg y hhi 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);

* Create covariates for threshold of 10%;	
	
replace shared = shared10;
replace leez = leez10;
replace hhi =hhi10;
replace hs = hs10;	

* Panel regressions for threshold at 10%;
	
eststo shared10:quietly xtreg y shared 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
eststo eez10:quietly xtreg y leez 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
eststo hhi10:quietly xtreg y hhi 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);	

* Create covariates for threshold of 15%;
	
replace shared = shared15;
replace leez = leez15;
replace hhi =hhi15;
replace hs = hs15;

* Panel regressions for threshold at 15%;

eststo shared15:quietly xtreg y shared 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
eststo eez15:quietly xtreg y leez 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
eststo hhi15:quietly xtreg y hhi 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);

	
* Create covariates for threshold of 20%;	
	
replace shared = shared20;
replace leez = leez20;
replace hhi =hhi20;
replace hs = hs20;

* Panel regressions for threshold at 20%;	
	
eststo shared20:quietly xtreg y shared 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
eststo eez20:quietly xtreg y leez 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
eststo hhi20:quietly xtreg y hhi 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);

* Create covariates for threshold of 25%;	
	
replace shared = shared25;
replace leez = leez25;
replace hhi =hhi25;
replace hs = hs25;	

* Panel regressions for threshold at 25%;
	
eststo shared25:quietly xtreg y shared 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
eststo eez25:quietly xtreg y leez 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
eststo hhi25:quietly xtreg y hhi 
	hs age max i.cate 
	iq itq ivq coop communityquota turf mult 
	i.space##i.year	
	, vce(cluster clust);
	
* Create output labels;	
	
label variable shared "Shared";	
label variable leez "EEZ";
label variable hhi "Herfindahl-Hirschman";		
	
* Stata table;	
esttab, keep(*shared *eez *hhi) 
	se(%3.2f) b(2) label compress obslast nomtitles nonum
	mgroups("0%" "5%" "10%" "15%" "20%" "25%",
		pattern(1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0))
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o R^2" "rho rho");

esttab using "b_bmsy_full.tex", replace keep(*shared *eez *hhi)
	compress se(%3.2f) b(2) label obslast
	mgroups("0\%" "5\%" "10\%" "15\%" "20\%" "25\%",
		pattern(1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle nonumbers substitute(~  $)
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o ~R^2~" "rho ~\rho~");		

* Results 0% - 10% LaTeX;
	
esttab shared0 eez0 hhi0 shared5 eez5 hhi5 shared10 eez10 hhi10
	using "b_bmsy_p1.tex", replace keep(*shared *eez *hhi)
	compress se(%3.2f) b(2) label obslast
	mgroups("0\%" "5\%" "10\%",
		pattern(1 0 0 1 0 0 1 0 0)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle nonumbers substitute(~  $)
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o ~R^2~" "rho ~\rho~");

* Results 15% - 25% LaTeX;
	
esttab shared15 eez15 hhi15 shared20 eez20 hhi20 shared25 eez25 hhi25
	using "b_bmsy_p2.tex", replace keep(*shared *eez *hhi)
	compress se(%3.2f) b(2) label obslast
	mgroups("15\%" "20\%" "25\%",
		pattern(1 0 0 1 0 0 1 0 0)
		prefix(\multicolumn{@span}{c}{) suffix(}) span erepeat(\cmidrule(lr){@span}))
	nomtitle nonumbers substitute(~  $)
	star(+ 0.10 * 0.05 ** 0.01 *** 0.001)
	scalars("r2_o ~R^2~" "rho ~\rho~");	
	
* Full set of results csv;
	
esttab using "b_bmsy_full.csv", nostar replace se
	keep(*shared *eez *hhi)
	mgroups("0\%" "5\%" "10\%" "15\%" "20\%" "25\%",
		pattern(1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0))
	noobs nomtitle;
	
