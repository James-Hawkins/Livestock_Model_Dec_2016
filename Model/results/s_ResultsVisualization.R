setwd("D:/Users/JHAWKINS/Dropbox (IFPRI)/Research/PROJECTS/Livestock_Optimization/Model/Results")
# C:/Users/admin/Dropbox (IFPRI)/Research/PROJECTS/Livestock_Optimization/R Analysis/Malawi
# D:\Users\JHAWKINS\Dropbox (IFPRI)\Research\PROJECTS\Livestock_Optimization\R Analysis\Malawi

require(xlsx)
d_results<-NA
d_results<-read.csv("ResultsSummary.csv")

library(reshape)    # This is the package needed to use the 'rename' function


View(d_results)
#
# plot(x=NULL, y=NULL,  xlim=range(1:10),ylim=range(1e-9:1),log="y")

#Income
png(file="Income.png",width=400,height=350)
plot(d_results[d_results$SCENARIO==1,"Income"],ylim=range(0:1200000), main="Livestock Income by Scenario", type="p", col="blue",ylab="Malawi Kwacha per year",xlab="Year")
lines(d_results[d_results$SCENARIO==2,"Income"], type="p", col="red")
legend('topright',legend=c("Base Scenario","Optimization Scenario"),col=c("blue","red"),pch=c(1,1))
dev.off()

# Production
# Milk
png(file="Milk.png",width=400,height=350)
plot(d_results[d_results$SCENARIO==1,"Milk"], ylim=range(0:600000),main="Milk Production by Scenario",type="p", col="blue",ylab="Kilograms per year",xlab="Year")
lines(d_results[d_results$SCENARIO==2,"Milk"], type="p", col="red")
legend('topright',legend=c("Base Scenario","Optimization Scenario"),col=c("blue","red"),pch=c(1,1))
dev.off()

# Meat
png(file="Meat.png",width=400,height=350)
plot(d_results[d_results$SCENARIO==1,"Meat"],ylim=range(0:500000),main="Meat Production by Scenario", type="p", col="blue",ylab="Kilograms per year",xlab="Year")
lines(d_results[d_results$SCENARIO==2,"Meat"], type="p", col="red",)
legend('topright',legend=c("Base Scenario","Optimization Scenario"),col=c("blue","red"),pch=c(1,1))
dev.off()

# Livestock numbers
png(file="Livestock_Base.png",width=400,height=350)
plot(d_results[d_results$SCENARIO==1,"Calves"],main="Animal Numbers in Base Scenario", type="o", col="blue", ylim=c(0,12),ylab="Livestock Numbers in Base Scenario (hd)",xlab="Year")
lines(d_results[d_results$SCENARIO==1,"Heifers"], type="o", col="red", ylim=c(0,12))
lines(d_results[d_results$SCENARIO==1,"Cows"], type="o", col="green", ylim=c(0,12))
legend('topright',legend=c("Calves","Heifers","Cows"),col=c("blue","red","green"),pch=c(1,1))
dev.off()

png(file="Livestock_Opti.png",width=400,height=350)
plot(d_results[d_results$SCENARIO==2,"Calves"],main="Animal Numbers in Optimization Scenario", type="o", col="blue", ylim=c(0,12),ylab="Livestock Numbers under Optimization Scenario (hd)",xlab="Year")
lines(d_results[d_results$SCENARIO==2,"Heifers"], type="o", col="red", ylim=c(0,12))
lines(d_results[d_results$SCENARIO==2,"Cows"], type="o", col="green", ylim=c(0,12))
legend('topright',legend=c("Calves","Heifers","Cows"),col=c("blue","red","green"),pch=c(1,1))
dev.off()



