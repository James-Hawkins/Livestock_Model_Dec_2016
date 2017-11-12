Sets
* time sets
m twelve months                                  /m01*m12/
year years                                       /1*20,y01*y12/
y(year) years in model horizon                   /y01*y03/
y2(year) years in current run or recursive steps /1*10/

firsty(y2) /1/
firstm(m)  /m01/
lasty(y2)  /10/
lastm(m)   /m12/

* household sets
hh households          /hh1/

* animal activity related sets
aaact  animal activity /youngf_loc,youngm_loc,weanerf_loc,weanerm_loc,adultf_loc,reprod_loc,youngf_imp,youngm_imp,weanerf_imp,weanerm_imp,adultf_imp,reprod_imp/
aaact_loc(aaact)       /youngf_loc,youngm_loc,weanerf_loc,weanerm_loc,adultf_loc,reprod_loc/
aaact_imp(aaact)       /youngf_imp,youngm_imp,weanerf_imp,weanerm_imp,adultf_imp,reprod_imp/
young(aaact)           /youngm_loc,youngf_loc,youngm_imp,youngf_imp/
young_imp(aaact)       /youngm_imp,youngf_imp/
young_loc(aaact)       /youngm_loc,youngf_loc/
weaner(aaact)          /weanerm_loc,weanerf_loc,weanerm_imp,weanerf_imp/
weaner_loc(aaact)      /weanerm_imp,weanerf_imp/
weaner_imp(aaact)      /weanerm_loc,weanerf_loc/
adult(aaact)           /adultf_loc,reprod_loc,adultf_imp,reprod_imp/
adult_loc(aaact)       /adultf_loc,reprod_loc/
adult_imp(aaact)       /adultf_imp,reprod_imp/
adultf(aaact)          /adultf_loc,adultf_imp/
adultf_imp(aaact)      /adultf_imp/
adultf_loc(aaact)      /adultf_loc/
male(aaact)            /youngm_loc,weanerm_loc,reprod_loc,youngm_imp,weanerm_imp,reprod_imp/
male_loc(aaact)        /youngm_loc,weanerm_loc,reprod_loc/
male_imp(aaact)        /youngm_imp,weanerm_imp,reprod_imp/
reprod(aaact)          /reprod_loc,reprod_imp/
reprod_loc(aaact)      /reprod_loc/
reprod_imp(aaact)      /reprod_imp/
yfemale(aaact)         /youngf_loc,youngf_imp/
yfemale_loc(aaact)     /youngf_loc/
yfemale_imp(aaact)     /youngf_imp/
notadult(aaact)        /youngf_loc,youngm_loc,weanerf_loc,weanerm_loc,youngf_imp,youngm_imp,weanerf_imp,weanerm_imp/
notadultf(aaact)        /youngf_loc,youngm_loc,weanerf_loc,weanerm_loc,youngf_imp,youngm_imp,weanerf_imp,weanerm_imp,reprod_loc,reprod_imp/
notadult_loc(aaact)    /youngf_loc,youngm_loc,weanerf_loc,weanerm_loc/
notadult_imp(aaact)    /youngf_imp,youngm_imp,weanerf_imp,weanerm_imp/

* types of animals
type             /dairy/

inten intensity level for feeding  /ext,med,int/
*,med,int
minten level for maintenance       /ext,med,int/
*
feed feed source                   /maize_residue,cpea_residue,soyb_residue,grnut_residue,bean_residue,sorgh_residue,concentrate,grass,grass_hay/
;
