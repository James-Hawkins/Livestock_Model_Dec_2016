Equations
*-- Herd dynamics equations
   E_youngm_loc     'young balance each month excluding jan each year'
   E_youngy_loc     'from dec y-1 to jan y if y>1'
   E_youngm_loc2     'young balance each month excluding jan each year'
   E_fweanerm_loc   'female weaner balance each month excluding jan each year'
   E_fweanerm_loc2   'female weaner balance each month excluding jan each year'
   E_fweanery_loc   'from dec y-1 to jan y if y>1'
   E_mweanerm_loc   'male weaner balance each month excluding jan each year'
   E_mweanerm_loc2   'male weaner balance each month excluding jan each year'
   E_mweanery_loc   'from dec y-1 to jan y if y>1'
   E_adultfm_loc    'breeder balance each month excluding jan each year'
   E_adultfm_loc2    'breeder balance each month excluding jan each year'
   E_adultfy_loc    'breeder balance from dec y-1 to jan y if y>1'
   E_adultfy_loc2
   E_adultfsold_loc   'must sell adults once reach end of productive life'
   E_adultfsold_loc2   'must sell adults once reach end of productive life'
   E_adultfsold_loc3
   E_malesales_loc
   E_malesales_loc2
   E_malesales_loc3

   E_youngm_imp     'young balance each month excluding jan each year'
   E_youngm_imp2     'young balance each month excluding jan each year'
   E_youngy_imp     'from dec y-1 to jan y if y>1'
   E_fweanerm_imp   'female weaner balance each month excluding jan each year'
   E_fweanerm_imp2   'female weaner balance each month excluding jan each year'
   E_fweanery_imp   'from dec y-1 to jan y if y>1'
   E_mweanerm_imp   'male weaner balance each month excluding jan each year'
   E_mweanerm_imp2   'male weaner balance each month excluding jan each year'
   E_mweanery_imp   'from dec y-1 to jan y if y>1'
   E_adultfm_imp    'breeder balance each month excluding jan each year'
   E_adultfm_imp2    'breeder balance each month excluding jan each year'
   E_adultfy_imp    'breeder balance from dec y-1 to jan y if y>1'
   E_adultfy_imp2
   E_adultfsold_imp   'must sell adults once reach end of productive life'
   E_adultfsold_imp2   'must sell adults once reach end of productive life'
   E_adultfsold_imp3
   E_malesales_imp
   E_malesales_imp2
   E_malesales_imp3

;

*** -- Herd demographics
** YOUNG
E_youngm_loc(hh,young_loc,type,y,m)$(ord(m) eq 2 and ord(y) eq 1)..
Sum((inten,minten),v_aactLev(hh,young_loc,type,inten,minten,y,m))=e=
Sum((inten,minten),
v0_aactLev(hh,'adultf_loc',type,inten,minten)*p_rateFert('adultf_loc',type,inten)*p_sexratio(young_loc,type,inten)+
v0_aactLev(hh,young_loc,type,inten,minten)*(1-p_grad(young_loc,type,inten))*(1-p_mort(young_loc,type,minten))
)
;

E_youngm_imp(hh,young_imp,type,y,m)$(ord(m) eq 2 and ord(y) eq 1 )..
Sum((inten,minten),v_aactLev(hh,young_imp,type,inten,minten,y,m))=e=
Sum((inten,minten),
v0_aactLev(hh,'adultf_imp',type,inten,minten)*p_rateFert('adultf_imp',type,inten)*p_sexratio(young_imp,type,inten)+
v0_aactLev(hh,young_imp,type,inten,minten)*(1-p_grad(young_imp,type,inten))*(1-p_mort(young_imp,type,minten))
)
;

E_youngm_loc2(hh,young_loc,type,y,m)$(ord(m) gt 2 )..
Sum((inten,minten),v_aactLev(hh,young_loc,type,inten,minten,y,m))=e=
Sum((inten,minten),
v_aactLev(hh,'adultf_loc',type,inten,minten,y,m-1)*p_rateFert('adultf_loc',type,inten)*p_sexratio(young_loc,type,inten)+
v_aactLev(hh,young_loc,type,inten,minten,y,m-1)*(1-p_grad(young_loc,type,inten))*(1-p_mort(young_loc,type,minten))
)
;

E_youngm_imp2(hh,young_imp,type,y,m)$(ord(m) gt 2 )..
Sum((inten,minten),v_aactLev(hh,young_imp,type,inten,minten,y,m))=e=
Sum((inten,minten),
v_aactLev(hh,'adultf_imp',type,inten,minten,y,m-1)*p_rateFert('adultf_imp',type,inten)*p_sexratio(young_imp,type,inten)+
v_aactLev(hh,young_imp,type,inten,minten,y,m-1)*(1-p_grad(young_imp,type,inten))*(1-p_mort(young_imp,type,minten))
)
;

E_youngy_loc(hh,young_loc,type,y,'m01')$(ord(y) gt 2 )..
sum((inten,minten),v_aactLev(hh,young_loc,type,inten,minten,y,'m01'))=e=
sum((inten,minten),v_aactLev(hh,'adultf_loc',type,inten,minten,y-1,'m12')*p_rateFert('adultf_loc',type,inten)*p_sexratio(young_loc,type,inten)
+ v_aactLev(hh,young_loc,type,inten,minten,y-1,'m12')*(1-p_grad(young_loc,type,inten))
);

E_youngy_imp(hh,young_imp,type,y,'m01')$(ord(y) gt 2)..
sum((inten,minten),v_aactLev(hh,young_imp,type,inten,minten,y,'m01'))=e=
sum((inten,minten),
v_aactLev(hh,'adultf_imp',type,inten,minten,y-1,'m12')*p_rateFert('adultf_imp',type,inten)*p_sexratio(young_imp,type,inten)+
v_aactLev(hh,young_imp,type,inten,minten,y-1,'m12')*(1-p_grad(young_imp,type,inten))*(1-p_mort(young_imp,type,minten))
);
;

** WEANERS

E_fweanerm_loc(hh,type,y,m)$(ord(m) eq 2 and ord(y) eq 1 )..
sum((inten,minten),v_aactLev(hh,'weanerf_loc',type,inten,minten,y,m))=e=
Sum((inten,minten),
v0_aactLev(hh,'youngf_loc',type,inten,minten)*p_grad('youngf_loc',type,inten)
+v0_aactLev(hh,'weanerf_loc',type,inten,minten)*(1-p_grad('weanerf_loc',type,inten))*(1-p_mort('weanerf_loc',type,minten))
+v_aactLevbuy(hh,'weanerf_loc',type,inten,minten,y,m-1));

E_fweanerm_imp(hh,type,y,m)$(ord(m) eq 2 and ord(y) eq 1 )..
*and sum(minten,v0_aactLev(hh,'weanerm_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerf_imp',type,inten,minten,y,m))=e=
sum((inten,minten),
v0_aactLev(hh,'youngf_imp',type,inten,minten)*p_grad('youngf_imp',type,inten)
+v0_aactLev(hh,'weanerf_imp',type,inten,minten)*(1-p_grad('weanerf_imp',type,inten))*(1-p_mort('weanerf_imp',type,minten))
+v_aactLevbuy(hh,'weanerf_imp',type,inten,minten,y,m-1))
;

E_fweanerm_loc2(hh,type,y,m)$(ord(m) gt 2 )..
*and sum(minten,v0_aactLev(hh,'weanerf_loc',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerf_loc',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'youngf_loc',type,inten,minten,y,m-1)*p_grad('youngf_loc',type,inten)
+v_aactLev(hh,'weanerf_loc',type,inten,minten,y,m-1)*(1-p_grad('weanerf_loc',type,inten))*(1-p_mort('weanerf_loc',type,minten))
+v_aactLevbuy(hh,'weanerf_loc',type,inten,minten,y,m-1));

E_fweanerm_imp2(hh,type,y,m)$(ord(m) gt 2 )..
*and sum(minten,v0_aactLev(hh,'weanerf_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerf_imp',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'youngf_imp',type,inten,minten,y,m-1)*p_grad('youngf_imp',type,inten)
+v_aactLev(hh,'weanerf_imp',type,inten,minten,y,m-1)*(1-p_grad('weanerf_imp',type,inten))*(1-p_mort('weanerf_imp',type,minten))
+v_aactLevbuy(hh,'weanerf_imp',type,inten,minten,y,m-1)
);

E_mweanerm_loc(hh,type,y,m)$(ord(m) eq 2 and ord(y) eq 1 )..
*and sum(minten,v0_aactLev(hh,'weanerm_loc',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerm_loc',type,inten,minten,y,m))=e=
sum((inten,minten),
v0_aactLev(hh,'youngm_loc',type,inten,minten)*p_grad('youngm_loc',type,inten)*(1-p_mort('weanerm_loc',type,minten))
+v0_aactLev(hh,'weanerm_loc',type,inten,minten)*(1-p_grad('weanerm_loc',type,inten))
+v_aactLevbuy(hh,'weanerm_loc',type,inten,minten,y,m-1));

E_mweanerm_imp(hh,type,y,m)$(ord(m) eq 2 and ord(y) eq 1 )..
* and sum(minten,v0_aactLev(hh,'weanerm_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerm_imp',type,inten,minten,y,m))=e=
Sum((inten,minten),
v0_aactLev(hh,'youngm_imp',type,inten,minten)*p_grad('youngm_imp',type,inten)*(1-p_mort('weanerm_imp',type,minten))
+v0_aactLev(hh,'weanerm_imp',type,inten,minten)*(1-p_grad('weanerm_imp',type,inten))
+v_aactLevbuy(hh,'weanerm_imp',type,inten,minten,y,m-1));

E_mweanerm_loc2(hh,type,y,m)$(ord(m) gt 2 )..
*and sum(minten,v0_aactLev(hh,'weanerm_loc',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerm_loc',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'youngm_loc',type,inten,minten,y,m-1)*p_grad('youngm_loc',type,inten)*(1-p_mort('weanerm_loc',type,minten))
+v_aactLev(hh,'weanerm_loc',type,inten,minten,y,m-1)*(1-p_grad('weanerm_loc',type,inten))
+v_aactLevbuy(hh,'weanerm_loc',type,inten,minten,y,m-1));

E_mweanerm_imp2(hh,type,y,m)$(ord(m) gt 2 )..
*and sum(minten,v0_aactLev(hh,'weanerm_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerm_imp',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'youngm_imp',type,inten,minten,y,m-1)*p_grad('youngm_imp',type,inten)*(1-p_mort('weanerm_imp',type,minten))
+v_aactLev(hh,'weanerm_imp',type,inten,minten,y,m-1)*(1-p_grad('weanerm_imp',type,inten))
+v_aactLevbuy(hh,'weanerm_imp',type,inten,minten,y,m-1));

E_fweanery_loc(hh,type,y,'m01')$(ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'weanerf_loc',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerf_loc',type,inten,minten,y,'m01'))=e=
sum((inten,minten),
v_aactLev(hh,'youngf_loc',type,inten,minten,y-1,'m12')*p_grad('youngf_loc',type,inten)*(1-p_mort('weanerf_loc',type,minten))
+v_aactLev(hh,'weanerf_loc',type,inten,minten,y-1,'m12')*(1-p_grad('weanerf_loc',type,inten))
+v_aactLevbuy(hh,'weanerf_loc',type,inten,minten,y-1,'m12')
);

E_fweanery_imp(hh,type,y,'m01')$(ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'weanerf_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerf_imp',type,inten,minten,y,'m01'))=e=
sum((inten,minten),v_aactLev(hh,'youngf_imp',type,inten,minten,y-1,'m12')*p_grad('youngf_imp',type,inten)*(1-p_mort('weanerf_imp',type,minten))
+v_aactLev(hh,'weanerf_imp',type,inten,minten,y-1,'m12')*(1-p_grad('weanerf_imp',type,inten))
+v_aactLevbuy(hh,'weanerf_imp',type,inten,minten,y-1,'m12'));

E_mweanery_loc(hh,type,y,'m01')$(ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'weanerm_loc',type,inten,minten))
sum((inten,minten),
v_aactLev(hh,'weanerm_loc',type,inten,minten,y,'m01'))=e=
sum((inten,minten),
v_aactLev(hh,'youngm_loc',type,inten,minten,y-1,'m12')*p_grad('youngm_loc',type,inten)*(1-p_mort('weanerm_loc',type,minten))
+v_aactLev(hh,'weanerm_loc',type,inten,minten,y-1,'m12')*(1-p_grad('weanerm_loc',type,inten))
+v_aactLevbuy(hh,'weanerm_loc',type,inten,minten,y-1,'m12'));

E_mweanery_imp(hh,type,y,'m01')$(ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'weanerm_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'weanerm_imp',type,inten,minten,y,'m01'))=e=
sum((inten,minten),
v_aactLev(hh,'youngm_imp',type,inten,minten,y-1,'m12')*p_grad('youngm_imp',type,inten)*(1-p_mort('weanerm_imp',type,minten))
+v_aactLev(hh,'weanerm_imp',type,inten,minten,y-1,'m12')*(1-p_grad('weanerm_imp',type,inten))*(1-p_mort('weanerm_imp',type,minten))
+v_aactLevbuy(hh,'weanerm_imp',type,inten,minten,y-1,'m12'));

** ADULTS
* y = 1 and m = 2
E_adultfm_loc(hh,type,y,m)$(ord(m) eq 2 and ord(y) eq 1 )..
*and sum(minten,v0_aactLev(hh,'adultf_loc',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'adultf_loc',type,inten,minten,y,m))=e=
sum((inten,minten),
v0_aactLev(hh,'weanerf_loc',type,inten,minten)*p_grad('weanerf_loc',type,inten)*(1-p_mort('weanerf_loc',type,minten))
+v0_aactLev(hh,'adultf_loc',type,inten,minten)*(1-p_grad('adultf_loc',type,inten))*(1-p_mort('adultf_loc',type,minten))
+v_aactLevbuy(hh,'adultf_loc',type,inten,minten,y,m-1))
;

E_adultfm_imp(hh,type,y,m)$(ord(m) eq 2 and ord(y) eq 1 )..
* and sum(minten,v0_aactLev(hh,'adultf_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'adultf_imp',type,inten,minten,y,m))=e=
sum((inten,minten),
v0_aactLev(hh,'weanerf_imp',type,inten,minten)*p_grad('weanerf_imp',type,inten) *(1-p_mort('weanerf_imp',type,minten))
+v0_aactLev(hh,'adultf_imp',type,inten,minten)*(1-p_grad('adultf_imp',type,inten))*(1-p_mort('adultf_imp',type,minten))
+v_aactLevbuy(hh,'adultf_imp',type,inten,minten,y,m-1))
;

* y = 1 and m > 2
E_adultfm_loc2(hh,type,y,m)$(ord(m) gt 2 and ord(y) eq 1 )..
*and sum(minten,v0_aactLev(hh,'adultf_loc',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'adultf_loc',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'weanerf_loc',type,inten,minten,y,m-1)*p_grad('weanerf_loc',type,inten)*(1-p_mort('weanerf_loc',type,minten))
+v_aactLev(hh,'adultf_loc',type,inten,minten,y,m-1)*(1-p_grad('adultf_loc',type,inten))*(1-p_mort('adultf_loc',type,minten))
+v_aactLevbuy(hh,'adultf_loc',type,inten,minten,y,m-1));

E_adultfm_imp2(hh,type,y,m)$(ord(m) gt 2 and ord(y) eq 1 )..
*and sum(minten,v0_aactLev(hh,'adultf_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'adultf_imp',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'weanerf_imp',type,inten,minten,y,m-1)*p_grad('weanerf_imp',type,inten) *(1-p_mort('weanerf_imp',type,minten))
+v_aactLev(hh,'adultf_imp',type,inten,minten,y,m-1)*(1-p_grad('adultf_imp',type,inten))*(1-p_mort('adultf_imp',type,minten))
+v_aactLevbuy(hh,'adultf_imp',type,inten,minten,y,m-1));

* y > 1 and m = 1
E_adultfy_loc(hh,type,y,'m01')$(ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'adultf_loc',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'adultf_loc',type,inten,minten,y,'m01'))=e=
sum((inten,minten),v_aactLev(hh,'weanerf_loc',type,inten,minten,y-1,'m12')*p_grad('weanerf_loc',type,inten)*(1-p_mort('weanerf_loc',type,minten))
+v_aactLev(hh,'adultf_loc',type,inten,minten,y-1,'m12')*(1-p_grad('adultf_loc',type,inten))*(1-p_mort('adultf_loc',type,minten))
+v_aactLevbuy(hh,'adultf_loc',type,inten,minten,y-1,'m12'));

E_adultfy_imp(hh,type,y,'m01')$(ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'adultf_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'adultf_imp',type,inten,minten,y,'m01'))=e=
sum((inten,minten),
v_aactLev(hh,'weanerf_imp',type,inten,minten,y-1,'m12')*p_grad('weanerf_imp',type,inten)*(1-p_mort('weanerf_imp',type,minten))
+v_aactLev(hh,'adultf_imp',type,inten,minten,y-1,'m12')*(1-p_grad('adultf_imp',type,inten))*(1-p_mort('adultf_imp',type,minten))
+v_aactLevbuy(hh,'adultf_imp',type,inten,minten,y-1,'m12'));

* y > 1 and m > 1
E_adultfy_loc2(hh,type,y,m)$(ord(y) gt 1 and ord(m) gt 1 )..
*and sum(minten,v0_aactLev(hh,'adultf_loc',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'adultf_loc',type,inten,minten,y,m))=e=
sum((inten,minten),v_aactLev(hh,'weanerf_loc',type,inten,minten,y,m-1)*p_grad('weanerf_loc',type,inten)*(1-p_mort('weanerf_loc',type,minten))
+v_aactLev(hh,'adultf_loc',type,inten,minten,y,m-1)*(1-p_grad('adultf_loc',type,inten))*(1-p_mort('adultf_loc',type,minten))
+v_aactLevbuy(hh,'adultf_loc',type,inten,minten,y,m-1));

E_adultfy_imp2(hh,type,y,m)$(ord(y) gt 1 and ord(m) gt 1 )..
*and sum(minten,v0_aactLev(hh,'adultf_imp',type,inten,minten))
sum((inten,minten),v_aactLev(hh,'adultf_imp',type,inten,minten,y,m))=e=
sum((inten,minten),v_aactLev(hh,'weanerf_imp',type,inten,minten,y,m-1)*p_grad('weanerf_imp',type,inten)*(1-p_mort('weanerf_imp',type,minten))
+v_aactLev(hh,'adultf_imp',type,inten,minten,y,m-1)*(1-p_grad('adultf_imp',type,inten))*(1-p_mort('adultf_imp',type,minten))
+v_aactLevbuy(hh,'adultf_imp',type,inten,minten,y,m-1));

* Sales

E_adultfsold_loc2(hh,type,y,m)$((ord(m) gt 1) )..
*and sum(minten,v0_aactLev(hh,'adultf_loc',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'adultf_loc',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'adultf_loc',type,inten,minten,y,m)*p_grad('adultf_loc',type,inten)*(1-p_mort('adultf_loc',type,minten)));
;

E_adultfsold_imp2(hh,type,y,m)$((ord(m) gt 1) )..
*and sum(minten,v0_aactLev(hh,'adultf_imp',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'adultf_imp',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'adultf_imp',type,inten,minten,y,m)*p_grad('adultf_imp',type,inten)*(1-p_mort('adultf_imp',type,minten)));
;


E_adultfsold_loc3(hh,type,y,m)$(ord(m) eq 1 and ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'adultf_loc',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'adultf_loc',type,inten,minten,y,m))=e=
Sum((inten,minten),
v_aactLev(hh,'adultf_loc',type,inten,minten,y-1,'m12')*p_grad('adultf_loc',type,inten)*(1-p_mort('adultf_loc',type,minten)));
;

E_adultfsold_imp3(hh,type,y,m)$(ord(m) eq 1 and ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'adultf_imp',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'adultf_imp',type,inten,minten,y,m))=e=
Sum((inten,minten),
v_aactLev(hh,'adultf_imp',type,inten,minten,y-1,'m12')*p_grad('adultf_imp',type,inten)*(1-p_mort('adultf_imp',type,minten)));

** Males are sold as they reach maturity (adult)
E_malesales_loc(hh,type,y,m)$(ord(m) eq 1 and ord(y) eq 1 )..
*and sum(minten,v0_aactLev(hh,'weanerm_loc',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'weanerm_loc',type,inten,minten,y,m))=e=
sum((inten,minten),
v0_aactLev(hh,'weanerm_loc',type,inten,minten)*(p_grad('weanerm_loc',type,inten))*(1-p_mort('weanerm_loc',type,minten)))
;

E_malesales_imp(hh,type,y,m)$(ord(m) eq 1 and ord(y) eq 1 )..
*and sum(minten,v0_aactLev(hh,'weanerm_imp',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'weanerm_imp',type,inten,minten,y,m))=e=
sum((inten,minten),
v0_aactLev(hh,'weanerm_imp',type,inten,minten)*(p_grad('weanerm_imp',type,inten))*(1-p_mort('weanerm_imp',type,minten)))
;

E_malesales_loc2(hh,type,y,m)$((ord(m) gt 1) )..
*and sum(minten,v0_aactLev(hh,'weanerm_loc',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'weanerm_loc',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'weanerm_loc',type,inten,minten,y,m-1)*(p_grad('weanerm_loc',type,inten))*(1-p_mort('weanerm_loc',type,minten)))
;

E_malesales_imp2(hh,type,y,m)$((ord(m) gt 1) )..
*and sum(minten,v0_aactLev(hh,'weanerm_imp',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'weanerm_imp',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'weanerm_imp',type,inten,minten,y,m-1)*(p_grad('weanerm_imp',type,inten))*(1-p_mort('weanerm_imp',type,minten)))
;

E_malesales_loc3(hh,type,y,m)$(ord(m) eq 1 and ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'weanerm_loc',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'weanerm_loc',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'weanerm_loc',type,inten,minten,y-1,'m12')*(p_grad('weanerm_loc',type,inten))*(1-p_mort('weanerm_loc',type,minten)))
;

E_malesales_imp3(hh,type,y,m)$(ord(m) eq 1 and ord(y) gt 1 )..
*and sum(minten,v0_aactLev(hh,'weanerm_imp',type,inten,minten))
sum((inten,minten),v_aactLevsell(hh,'weanerm_imp',type,inten,minten,y,m))=e=
sum((inten,minten),
v_aactLev(hh,'weanerm_imp',type,inten,minten,y-1,'m12')*(p_grad('weanerm_imp',type,inten))*(1-p_mort('weanerm_imp',type,minten)))
;








Model demogMod    /
   E_youngm_loc
   E_youngy_loc
   E_youngm_loc2
   E_fweanerm_loc
   E_fweanerm_loc2
   E_fweanery_loc
   E_mweanerm_loc
   E_mweanerm_loc2
   E_mweanery_loc
   E_adultfm_loc
   E_adultfm_loc2
   E_adultfy_loc
   E_adultfy_loc2
   E_adultfsold_loc2
   E_adultfsold_loc3
   E_malesales_loc
   E_malesales_loc2
   E_malesales_loc3


   E_youngm_imp
   E_youngy_imp
   E_youngm_imp2
   E_fweanerm_imp
   E_fweanerm_imp2
   E_fweanery_imp
   E_mweanerm_imp
   E_mweanerm_imp2
   E_mweanery_imp
   E_adultfm_imp
   E_adultfm_imp2
   E_adultfy_imp
   E_adultfy_imp2
   E_adultfsold_imp2
   E_adultfsold_imp3
   E_malesales_imp
   E_malesales_imp2
   E_malesales_imp3
/
;
