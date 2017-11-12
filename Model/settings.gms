$setglobal filelocation  C:\Users\Gaming\Documents\Github\Livestock_Model_Dec2016\Model

$setglobal filelocation C:\Users\admin\Dropbox (IFPRI)\Research\PROJECTS\Livestock_Optimization\Model
*D:\Users\JHAWKINS\Dropbox(IFPRI)\Research\PROJECTS\Livestock_Optimization\Model


$setglobal resdir  '%filelocation%results'
$setglobal datdir  '%filelocation%data'


* Global Variables
* Scenario for basic model optimization
$setglobal BASESCEN OFF
* scneario for simulation 1: local cows, grass based diet, low animal expenses
$setglobal SIMU_1 OFF
* scneario for simulation 2: same as 1 except improved cows
$setglobal SIMU_2 OFF
* scneario for simulation 3: same as 1 except improved diets
$setglobal SIMU_3 OFF
* scneario for simulation 4: same as 1 except improved management of livestock (greater veterinary care, ...)
$setglobal SIMU_4 OFF
* scenario defining variability in forage production
$Setglobal CLIMATESCEN OFF
