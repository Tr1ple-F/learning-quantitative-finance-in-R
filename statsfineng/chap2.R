dat = read.csv("./datasets/Stock_Bond.csv",header=TRUE)
names(dat)
attach(dat)
par(mfrow=c(1,2))
plot(GM_AC,type="l")
plot(F_AC)

n = dim(dat)[1]
GMReturn = GM_AC[2:n]/GM_AC[1:(n-1)] - 1
FReturn = F_AC[2:n]/F_AC[1:(n-1)] - 1
lGMReturn = log(GM_AC[2:n]/GM_AC[1:(n-1)])
lFReturn = log(F_AC[2:n]/F_AC[1:(n-1)])


par(mfrow=c(1,1))
plot(GMReturn,FReturn)
plot(lGMReturn, GMReturn)

rm(list=ls(all=TRUE))
niter = 1e5
below = rep(0,niter)
above = rep(0,niter)
set.seed(2009)
options(warn=-1)
for (i in 1:niter)
{
  r = rnorm(100,mean=.05/253,sd=.23/sqrt(253))
  logPrice = log(1e6) + cumsum(r)
  minlogP = min(logPrice)
  maxlogP = max(logPrice)
  below[i] = as.numeric(minlogP < log(950000))
  above[i] = as.numeric(maxlogP > log(1100000))
}
mean(below)
mean(above)