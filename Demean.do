clear
set obs 100
gen x1=rnormal()*sqrt(2)+1 // mean 1
gen x2=2*x1+rnormal()+1  // mean 3
gen x12=x1*x2
scalar beta1=-3
scalar beta2=-1
scalar gamma=1
gen y=beta1*x1+beta2*x2+gamma*x12+rchi2(2)

// deman
egen mean_x1=mean(x1)
egen mean_x2=mean(x2)
gen demean_x1=x1-mean_x1
gen demean_x2=x2-mean_x2
gen demean_x12=demean_x1*demean_x2

// regression
reg y x1 x2 x12
reg y demean_x1 demean_x2 demean_x12
