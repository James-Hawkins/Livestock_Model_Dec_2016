$ontext

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*


$offtext
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
$onglobal



*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
* #2 Variables  (all variables are declared in terms of generic sets)
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
Variables
  v_aactLev(hh,aaact,type,inten,minten,year,m)          'livestock activity level (head)'
  v_aactLevsell(hh,aaact,type,inten,minten,year,m)      'sell livestock (head)'
  v_aactLevbuy(hh,aaact,type,inten,minten,year,m)       'buy livestock (head)'

  v_residuesfeedm(hh,feed,year,m)                 'residues allocated to feeed per month'

  v_totallabourdemlive(hh,year,m)                 'days labour/month/flock or herd'

  v_prodQmilk(hh,aaact,type,inten,year,m)        'milk produced, L/month/animal'
  v_prodQmeat(hh,aaact,type,inten,year,m)        'meat produced, kg/month/animal'

  v_feedbalance(hh,feed,year,m)                  'kg feed carried over to next month'
  v_feedbalance2(hh,feed,year,m)                 'kg feed carried over to next month'
  v_fdcons(hh,aaact,type,inten,y,m,feed)         'amount of a specific feed consumed per animal per month (kg DM)'
  v_feedons(hh,feed,year,m)                      'total kg of a feed consumed per month'

  v_feedbuy(hh,feed,y,m)                         'kg of a feed purchased'
  v_maintIntensity(aaact,type,inten,minten)      'maintenance intensity of livestock (int or ext)'
  dummy                                          'dummy objective variable for model simulations'
;

Variables
  v_npv                                            'net present value'
  v_income(hh,year)                                'annual household income'
  v_residuesfeedm(hh,feed,year,m)                  'residues of feed coming from on farm production'
;



*fix starting values for livestock numbers in first month and first year (assume extensive to begin)
v_aactLev.fx(hh,aaact,type,inten,minten,'y01','m01')=v0_aactLev(hh,aaact,type,inten,minten);

*fix all livestock numbers to zero if livestock are not observed in first month and first year (note, this should be not be included when breed selection is a decision variable)
*v_aactLev.fx(hh,aaact,type,inten,minten,y,m)$(v0_aactLev(hh,aaact,type,inten,minten)=0)=0;

*can't sell, buy, or consume any young, weaner or reproduction livestock or livestock that weren't in first month and first year
*v_aactLevsell.fx(hh,aaact,type,inten,minten,y,m)$(v0_aactLev(hh,aaact,type,inten,minten)=0)=0;
*v_aactLevbuy.fx(hh,aaact,type,inten,minten,y,m)$(v0_aactLev(hh,aaact,type,inten,minten)=0)=0;
* can't sell, buy, or slaughter local reproduction animals
*v_aactLevsell.fx(hh,'reprod_loc',type,inten,minten,y,m)=0;
v_aactLevbuy.fx(hh,'reprod_loc',type,inten,minten,y,m)=0;
* can't sell, buy, or slaughter reproductive animals
*v_aactLevsell.fx(hh,'reprod_imp',type,inten,minten,y,m)=0;
v_aactLevbuy.fx(hh,'reprod_imp',type,inten,minten,y,m)=0;
v_aactLevSELL.fx(hh,'reprod_imp',type,inten,minten,y,m)=0;
v_aactLevSELL.fx(hh,'reprod_loc',type,inten,minten,y,m)=0;  

* can't sell, buy, or slaughter non adults
*v_aactLevsell.fx(hh,notadult,type,inten,minten,y,m)=0;
v_aactLevsell.fx(hh,'weanerf_loc',type,inten,minten,y,m)=0;
v_aactLevsell.fx(hh,'weanerf_imp',type,inten,minten,y,m)=0;
v_aactLevsell.fx(hh,'weanerf_loc',type,inten,minten,y,m)=0;
v_aactLevsell.fx(hh,'weanerm_imp',type,inten,minten,y,m)=0;

v_aactLevbuy.fx(hh,young,type,inten,minten,y,m)=0;
v_aactLevsell.fx(hh,young,type,inten,minten,y,m)=0;

*v_aactLevsell.fx(hh,aaact,type,inten,lasty,lastm)=0;
*v_aactLevbuy.fx(hh,aaact,type,inten,lasty,lastm)=0;
*v_aactLevslaughter.fx(hh,aaact,type,inten,lasty,lastm)=0;

*v_residuesbuy.fx(reg,inout,year,m)=0;
*v_residuessellm.fx(reg,inout,year,m)=0;

p_s(hh,feed)=p_feedSupply(hh,feed);


*v_residuesfeedm.fx(hh,feed,y,'m06')$(ord(y) gt 1)=   300;
*v_residuesbuy.fx(hh,feed,y,m)         =0;



** Variable Bounds  (to prevent calcualtion errors)
** feed related bounds
v_feedbalance.lo(hh,feed,y,m) = -eps;
v_residuesfeedm.lo(hh,feed,y,m)=-eps;
v_feedbuy.lo(hh,feed,y,m)=-eps;
v_feedons.lo(hh,feed,y,m)=-eps;

**animal related bounds
v_aactLev.lo(hh,aaact,type,inten,minten,year,m)=0;
v_aactLevbuy.lo(hh,aaact,type,inten,minten,year,m)=0;
v_aactLevsell.lo(hh,aaact,type,inten,minten,year,m)=0;

** productivity related bounds
v_prodQmilk.fx(hh,notadultf,type,inten,year,m)=0;




*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
* #3 Equations  (all variables are declared in terms of sets specifically defined to this model scenario)
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
Equations

*--objective function
   E_objective1       'objective function'
   E_objective2       'objective function for model simulations (dummy)'
   E_income           'income definition'

*-- production equations
   E_milkproduction   'milk produced'
   E_meatproduction   'meat produced from slaughtered animals'

*-- Feed balance equations
   E_feedbal       'livestock feed balance accounting equation'
   E_feedons       'total amount of a feed consumed per month'

*-- Labor equation
   E_laborAA     'labor use for livestock activities'

*-- Cash and Animal Constraint
   E_cashconstraint  'maximum amount of money that can be spent per year'
   E_animalcapacity  'maximum holding capacity for livestock'


;

**Equation Definitions

*-- objective functions
E_income(hh,y)..
v_income(hh,y) =e=
sum((type,inten,m,aaact),v_prodQmeat(hh,aaact,type,inten,y,m)*p_meatPrice)+
sum((type,inten,m,aaact),v_prodQmilk(hh,aaact,type,inten,y,m)*p_milkPrice)
-sum((aaact,type,inten,minten,m),v_aactLevbuy(hh,aaact,type,inten,minten,y,m)*p_purchPrice(hh,aaact))
-sum(m,v_totallabourdemlive(hh,y,m)*p_labourPrice(hh))
-sum((m,feed),v_feedbuy(hh,feed,y,m)*p_feedprice(feed))
-sum((aaact,type,m,inten,minten),v_aactLev(hh,aaact,type,inten,minten,y,m)*p_maintExpense(hh,aaact,type,minten)/12);

E_objective1.. v_npv =e= sum((hh,y),v_income(hh,y));

E_objective2.. dummy =e= 10 ;



*-- Cash constraint
E_cashconstraint(hh,y,m)..   Sum((aaact,type,inten,minten),v_aactLevbuy(hh,aaact,type,inten,minten,y,m)*p_purchPrice(hh,aaact)) =l= v_income(hh,y)/12 ;
*v_income(hh,y);

*--  livestock production
*milk
E_milkproduction(hh,aaact,type,inten,y,m)..   v_prodQmilk(hh,aaact,type,inten,y,m) =e=p_milkprod(aaact,type,inten)*30*Sum(minten,v_aactLev(hh,aaact,type,inten,minten,y,m));

*meat
E_meatproduction(hh,aaact,type,inten,y,m)..    v_prodQmeat(hh,aaact,type,inten,y,m)  =e= p_salesw(aaact,type,inten)*Sum(minten,v_aactLevsell(hh,aaact,type,inten,minten,y,m));

**-- Feed balance equations
E_feedons(hh,feed,y,m)..v_feedons(hh,feed,y,m) =e= sum((aaact,type,inten,minten)$v0_aactLev(hh,aaact,type,inten,minten),v_aactLev(hh,aaact,type,inten,minten,y,m)*p_fdcons(hh,aaact,type,inten,y,m,feed));

E_feedbal(hh,feed,y,m).. v_feedbalance(hh,feed,y,m-1)*(p_transferrate)$(ord (m) gt 1) + v_feedbalance(hh,feed,y-1,'m12')*(p_transferrate)$((ord (y) gt 1) and (ord(m) eq 1)) + p_s(hh,feed)$((ord(m) eq 1) and (ord(y) eq 1))+ v_residuesfeedm(hh,feed,y,m) + v_feedbuy(hh,feed,y,m)- v_feedons(hh,feed,y,m)=e= v_feedbalance(hh,feed,y,m);

*labour demand
E_laborAA(hh,y,m).. sum((aaact,inten,type,minten),v_aactLev(hh,aaact,type,inten,minten,y,m)*p_labour(m,inten,aaact,type)) =e= v_totallabourdemlive(hh,y,m);

E_animalcapacity(hh,y,m)..  Sum((aaact,type,inten,minten),v_aactLev(hh,aaact,type,inten,minten,y,m)) =l= p_LivesCapacity(hh);


option limrow=0; option limcol=0;


