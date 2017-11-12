$ontext
***************************
This model optimizes value of livestock over a recursive stochastic inter temporal horizon.

Choice variables are feeding regimen, livestock purchases (choice between local vs. improved), and livestock management intensity (which determines mortality levels per animal)

***************************
$offtext



$include settings.gms

* Set Declarations
$include set_definitions.gms

* Data load in
$include "data\parameters.gms"

* Livestock Module
$include livestock_module.gms

* Livestock Demographic Module
$include demographic_module.gms

* Include module to define scenarios
$include Scenario_Module.gms

* MODEL DEFINITION

Model livesMod /
   E_milkproduction
   E_meatproduction

   E_feedons
   E_feedbal

   E_laborAA

   E_CashConstraint
   E_AnimalCapacity

   E_income
   E_objective2
   E_objective1

*   demogMod
$ifi %BASESCEN%== ON demogMod
*$ifi %SIMU_2%== ON demogMod
*$ifi %SIMU_3%== ON demogMod
*$ifi %SIMU_4%== ON demogMod
/
;







Parameter
p_YieldVariation(year,feed)

* results storage parameters
results1(*)
results2(*,*)
results3(*,*,*)
results4(*,*,*,*)
results5(*,*,*,*,*)
results6(*,*,*,*,*,*)
results7(*,*,*,*,*,*,*)
results8(*,*,*,*,*,*,*,*)

beta(feed) variability of feed crops
/
grass             30
maize_residue       30
/
$ontext
additional feed sources
maize_straw 30
bean      30
bean_straw      30
soybean   30
soybean_straw   30
groundnut 30
groundnut_straw 30
cowpea    30
cowpea_straw    30
grass     30
/
$offtext
;

* yield for a given year is defined based on a random uniform distribution
p_YieldVariation(y2,feed)= 1 + (uniform(-1,1)*beta(feed)/100);



** Optimization Loop
*v0_aactLev(hh,aaact,type,inten,'ext')=startlivestock(hh,aaact,type,inten,"startvalue");

Loop(y2,



* for first month of first model year, set livestock numbers equal to start values observed in data




*

* Specify feed availability throughout inter temporal horizon
v_residuesfeedm.fx(hh,feed,y,'m01')= 0;
v_residuesfeedm.fx(hh,feed,y,'m02')= 0;
v_residuesfeedm.fx(hh,feed,y,'m03')= 0;
v_residuesfeedm.fx(hh,feed,y,'m04')= 0;
v_residuesfeedm.fx(hh,feed,y,'m05')= 0;
$ifi %CLIMATESCEN%==ON v_residuesfeedm.fx(hh,feed,y,'m06')= p_feedSupply(hh,feed)
*p_YieldVariation(y2,feed);
$ifi %CLIMATESCEN%==OFF v_residuesfeedm.fx(hh,feed,y,'m06')= p_feedSupply(hh,feed);
v_residuesfeedm.fx(hh,feed,y,'m07')= 0;
v_residuesfeedm.fx(hh,feed,y,'m08')= 0;
v_residuesfeedm.fx(hh,feed,y,'m09')= 0;
v_residuesfeedm.fx(hh,feed,y,'m10')= 0;
v_residuesfeedm.fx(hh,feed,y,'m11')= 0;
v_residuesfeedm.fx(hh,feed,y,'m12')= 0;

* Specify that feed availability in current year is equal to average yied corrected by a random yield variation coefficient
$ifi %CLIMATESCEN%==ON v_residuesfeedm.fx(hh,feed,'y01','m06')= p_feedSupply(hh,feed)*p_YieldVariation(y2,feed);

$ifi %BASESCEN%==ON v_aactLevsell.fx(hh,'adultf_imp',type,inten,minten,'y01','m01') = v_aactLev.l(hh,'adultf_imp',type,inten,minten,'y01','m12')*p_grad('adultf_imp',type,inten)*(1-p_mort('adultf_imp',type,minten));

$ifi %BASESCEN%==ON v_aactLevsell.fx(hh,'adultf_loc',type,inten,minten,'y01','m01')= v_aactLev.l(hh,'adultf_loc',type,inten,minten,'y01','m12')*p_grad('adultf_loc',type,inten)*(1-p_mort('adultf_loc',type,minten));




$ifi %BASESCEN%==OFF  SOLVE livesMod maximizing DUMMY using NLP;
$ifi %BASESCEN%==ON  SOLVE livesMod maximizing v_npv using NLP;


** Store results
results1('Model Status')=livesMod.modelstat;

results8('Animal Activity Levels (head)',hh,aaact,type,inten,minten,y2,m)=v_aactLev.l(hh,aaact,type,inten,minten,'y01',m);


** re-initializations
p_s(hh,feed)=v_feedbalance.l(hh,feed,'y01','m12')*(p_transferrate);
** re initialize month 1 animal numbers here from month 12 of 'y01'
** note: to allow transitions between intensity levels, sum rhs of below equations over all 'type'


v0_aactLev(hh,young_imp,type,inten,minten)=
v_aactLev.l(hh,'adultf_imp',type,inten,minten,'y01','m12')*p_rateFert('adultf_imp',type,inten)*p_sexratio(young_imp,type,inten)+
v_aactLev.l(hh,young_imp,type,inten,minten,'y01','m12')*(1-p_grad(young_imp,type,inten))*(1-p_mort(young_imp,type,minten))
;

v0_aactLev(hh,young_loc,type,inten,minten)=
v_aactLev.l(hh,'adultf_loc',type,inten,minten,'y01','m12')*p_rateFert('adultf_loc',type,inten)*p_sexratio(young_loc,type,inten)+
v_aactLev.l(hh,young_loc,type,inten,minten,'y01','m12')*(1-p_grad(young_loc,type,inten))*(1-p_mort(young_loc,type,minten))
;

v0_aactLev(hh,'weanerf_imp',type,inten,minten)=
v_aactLev.l(hh,'youngf_imp',type,inten,minten,'y01','m12')*p_grad('youngf_imp',type,inten)
+v_aactLev.l(hh,'weanerf_imp',type,inten,minten,'y01','m12')*(1-p_grad('weanerf_imp',type,inten))*(1-p_mort('weanerf_imp',type,minten))
;

v0_aactLev(hh,'weanerf_loc',type,inten,minten)=
v_aactLev.l(hh,'youngf_loc',type,inten,minten,'y01','m12')*p_grad('youngf_loc',type,inten)
+v_aactLev.l(hh,'weanerf_loc',type,inten,minten,'y01','m12')*(1-p_grad('weanerf_loc',type,inten))*(1-p_mort('weanerf_loc',type,minten))
;

v0_aactLev(hh,'weanerm_imp',type,inten,minten)=
v_aactLev.l(hh,'youngm_imp',type,inten,minten,'y01','m12')*p_grad('youngm_imp',type,inten)
+v_aactLev.l(hh,'weanerm_imp',type,inten,minten,'y01','m12')*(1-p_grad('weanerm_imp',type,inten))*(1-p_mort('weanerf_imp',type,minten))
;

v0_aactLev(hh,'weanerm_loc',type,inten,minten)=
v_aactLev.l(hh,'youngm_loc',type,inten,minten,'y01','m12')*p_grad('youngm_loc',type,inten)
+v_aactLev.l(hh,'weanerm_loc',type,inten,minten,'y01','m12')*(1-p_grad('weanerm_loc',type,inten))*(1-p_mort('weanerf_loc',type,minten))
-v_aactLevsell.l(hh,'weanerm_loc',type,inten,minten,'y01','m12')
;

v0_aactLev(hh,'adultf_loc',type,inten,minten)=
v_aactLev.l(hh,'weanerf_loc',type,inten,minten,'y01','m12')*p_grad('weanerf_loc',type,inten)
+v_aactLev.l(hh,'adultf_loc',type,inten,minten,'y01','m12')*(1-p_grad('adultf_loc',type,inten))*(1-p_mort('adultf_loc',type,minten))
-v_aactLevsell.l(hh,'adultf_loc',type,inten,minten,'y01','m12')
+v_aactLevbuy.l(hh,'adultf_loc',type,inten,minten,'y01','m12');

v0_aactLev(hh,'adultf_imp',type,inten,minten)=
v_aactLev.l(hh,'weanerf_imp',type,inten,minten,'y01','m12')*p_grad('weanerf_imp',type,inten)
+v_aactLev.l(hh,'adultf_imp',type,inten,minten,'y01','m12')*(1-p_grad('adultf_imp',type,inten))*(1-p_mort('adultf_imp',type,minten))
-v_aactLevsell.l(hh,'adultf_imp',type,inten,minten,'y01','m12')
+v_aactLevbuy.l(hh,'adultf_imp',type,inten,minten,'y01','m12')
;


v_aactLev.fx(hh,aaact,type,inten,minten,'y01','m01')=v0_aactLev(hh,aaact,type,inten,minten);


results8('Animal Sales (hd)',hh,aaact,type,inten,minten,y2,m)=v_aactLevSell.l(hh,aaact,type,inten,minten,'y01',m);
results8('Animal Purchases (hd)',hh,aaact,type,inten,minten,y2,m)=v_aactLevbuy.l(hh,aaact,type,inten,minten,'y01',m);
*results8('Animal Deaths (hd)',hh,aaact,type,inten,minten,y2,m)=;

results5('Feed Balance',hh,feed,y2,m)=v_feedbalance.l(hh,feed,'y01',m);
results5('Residues as Feed',hh,feed,y2,m)=v_residuesfeedm.l(hh,feed,'y01',m);
results5('Feed Consumption',hh,feed,y2,m)=v_feedons.l(hh,feed,'y01',m);

results3('Household Income (MK/yr)',hh,y2)= v_income.l(hh,'y01');
results3('Household Revenue (MK/yr)',hh,y2)=sum((type,inten,m,aaact),v_prodQmeat.l(hh,aaact,type,inten,'y01',m)*p_meatPrice)+sum((type,inten,m,aaact),v_prodQmilk.l(hh,aaact,type,inten,'y01',m)*p_milkPrice);
results3('Household Expenses (MK/yr)',hh,y2)=sum((aaact,type,inten,minten,m),v_aactLevbuy.l(hh,aaact,type,inten,minten,'y01',m)*p_purchPrice(hh,aaact))+sum(m,v_totallabourdemlive.l(hh,'y01',m)*p_labourPrice(hh))+sum((m,feed),v_feedbuy.l(hh,feed,'y01',m)*p_feedprice(feed))+sum((aaact,type,m,inten,minten),v_aactLev.l(hh,aaact,type,inten,minten,'y01',m)*p_maintExpense(hh,aaact,type,minten)/12);
results3('Replacement Costs(MK/yr)',hh,y2)=sum((aaact,type,inten,minten,m),v_aactLevbuy.l(hh,aaact,type,inten,minten,'y01',m)*p_purchPrice(hh,aaact));
results3('Feed Expenses(MK/yr)',hh,y2)= sum((m,feed),v_feedbuy.l(hh,feed,'y01',m)*p_feedprice(feed));
results3('Maintenance Expenses(MK/yr)',hh,y2)= sum((aaact,type,m,inten,minten),v_aactLev.l(hh,aaact,type,inten,minten,'y01',m)*p_maintExpense(hh,aaact,type,minten)/12);
results3('Milk Revenue (MK/y)',hh,y2)=sum((adultf,type,inten,m),v_prodQmilk.l(hh,adultf,type,inten,'y01',m));
results3('Meat Revenue (MK/y)',hh,y2)=Sum((aaact,type,inten,m),v_prodQmeat.l(hh,aaact,type,inten,'y01',m));


*milk and meat production
results3('Milk Production (kg/y)',hh,y2)=sum((adultf,type,inten,m),v_prodQmilk.l(hh,adultf,type,inten,'y01',m)*p_milkPrice);
results3('Meat Production (kg/y)',hh,y2)=Sum((aaact,type,inten,m),v_prodQmeat.l(hh,aaact,type,inten,'y01',m)*p_meatPrice);


** additional variables: livestock deaths, breakdown of expenses (maintenance expenses to total),



);

results6('Animal Activity Levels (head)',hh,aaact,type,inten,minten)=Sum((y2,m),results8('Animal Activity Levels (head)',hh,aaact,type,inten,minten,y2,m))/(card(m)*card(y2));

execute_unload "results/results.gdx"   results1, results2, results3, results4, results5, results6, results7, results8 ;

execute 'gdxxrw.exe results/results.gdx o=results/results.xls par=results1           rng=results1!'
execute 'gdxxrw.exe results/results.gdx o=results/results.xls par=results2           rng=results2!'
execute 'gdxxrw.exe results/results.gdx o=results/results.xls par=results3           rng=results3!'
execute 'gdxxrw.exe results/results.gdx o=results/results.xls par=results4           rng=results4!'
execute 'gdxxrw.exe results/results.gdx o=results/results.xls par=results5           rng=results5!'
execute 'gdxxrw.exe results/results.gdx o=results/results.xls par=results6           rng=results6!'
execute 'gdxxrw.exe results/results.gdx o=results/results.xls par=results7           rng=results7!'
execute 'gdxxrw.exe results/results.gdx o=results/results.xls par=results8           rng=results8!'
