*SIMU 1 ; SCENARIO REPRESENTING PRESENT DAY PRACTICES
** livestock numbers are fixed at what's observed in the data
$ifi %SIMU_1%==ON  v_aactLev.fx(hh,aaact,type,inten,minten,year,m)=v0_aactLev(hh,aaact,type,inten,minten);

*SIMU 2  ; GENETIC IMPROVEMENT SCENARIO
* specify that only improved dairy animals are in the herd
$ifi %SIMU_2%==ON  v0_aactLev(hh,aaact_loc,type,inten,minten)=0;
$ifi %SIMU_2%==ON  v0_aactLev(hh,aaact_imp,type,inten,minten)=1$(minten('ext') and type('dairy') and inten('ext'));

*SIMU 3  ; DIET IMPROVEMENT SCENARIO
$ifi %SIMU_3%==ON  v0_aactLev(hh,aaact,type,inten,minten)=0;
$ifi %SIMU_3%==ON  v0_aactLev(hh,aaact_loc,type,inten,minten)=1$(minten('ext') and type('dairy') and inten('int'));

*SIMU 4 ; MANAGEMENT IMPROVEMENT SCENARIO
$ifi %SIMU_4%==ON  v0_aactLev(hh,aaact,type,inten,minten)=0;
$ifi %SIMU_4%==ON  v0_aactLev(hh,aaact_loc,type,'ext','int')=startlivestock(hh,aaact_loc,type,'startvalue');



* For the management scenario simulations, fix livestock production variables
$ifi %BASESCEN%==OFF v_aactLev.fx(hh,aaact,type,inten,minten,year,m)=v0_aactLev(hh,aaact,type,inten,minten);
*offtake is set at a specific value
$ifi %BASESCEN%==OFF v_aactLevsell.fx(hh,aaact,type,inten,minten,year,m)=(v_aactLev.l(hh,aaact,type,inten,minten,year,m)*p_grad(aaact,type,inten)*(1-p_mort(aaact,type,minten)))$(adultf(aaact));
*purchases are set at a specific value  (calves transitioning to weaners minus weaners transitioning to adult)x(-1)
$ifi %BASESCEN%==OFF v_aactLevbuy.fx(hh,'weanerf_loc',type,inten,minten,year,m)=     v_aactLev.l(hh,'weanerf_loc',type,inten,minten,year,m)*(1-p_grad('weanerf_loc',type,inten))*(1-p_mort('weanerf_loc',type,minten))+ v_aactLev.l(hh,'youngf_loc',type,inten,minten,year,m)*p_grad('youngf_loc',type,inten)*(1-p_mort('youngf_loc',type,minten));
$ifi %BASESCEN%==OFF v_aactLevbuy.fx(hh,aaact,type,inten,minten,year,m)=v_aactLevsell.l(hh,aaact,type,inten,minten,year,m)-v_aactLev.l(hh,'weanerf_loc',type,inten,minten,year,m-1)*(1-p_grad('weanerf_loc',type,inten))*(1-p_mort('weanerf_loc',type,minten))$(adultf(aaact));





*$ifi %BASESCEN%==OFF v_aactLevsell.fx(hh,aaact,type,inten,minten,y,m)=0.025*v_aactLev.l(hh,aaact,type,inten,minten,year,m)$(weaner(aaact));
