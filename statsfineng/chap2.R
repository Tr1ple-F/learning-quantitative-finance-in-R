dat = read.csv("./datasets/Stock_Bond.csv",header=TRUE)
names(dat)
attach(dat)
par(mfrow=c(1,2))
plot(GM_AC,type="l")
plot(F_AC, type="l")

n = dim(dat)[1]
GMReturn = GM_AC[2:n]/GM_AC[1:(n-1)] - 1
FReturn = F_AC[2:n]/F_AC[1:(n-1)] - 1
lGMReturn = log(GM_AC[2:n]/GM_AC[1:(n-1)])
lFReturn = log(F_AC[2:n]/F_AC[1:(n-1)])

par(mfrow=c(1,1))
plot(GMReturn,FReturn)
plot(lGMReturn, GMReturn)

niter = 1e5 
below = rep(0, niter) 
set.seed(2009)
for (i in 1:niter)
{
  r = rnorm(45, mean = 0.05/253,
  sd = 0.23/sqrt(253))
  logPrice = log(1e6) + cumsum(r)
  minlogP = min(logPrice) 
  below[i] = as.numeric(minlogP < log(950000))
  }
mean(below)

#########################
# Hedge fund simulation #
#########################

rm(list=ls(all=TRUE))
niter = 1e6
below = rep(0,niter)
above = rep(0,niter)
loss = rep(0,niter)
profit = rep(0, niter)
days = rep(0,niter)
set.seed(2009)
options(warn=-1)
for (i in 1:niter)
{
  r = rnorm(100,mean=0.05/253,sd=.23/sqrt(253))
  logPrice = log(1e6) + cumsum(r)
  minI = Position(function(x) x < log(950000), logPrice)
  if (is.na(minI)) {
    minI = 101
  }
  maxI = Position(function(x) x > log(1100000), logPrice)
  if (is.na(maxI)) {
    maxI = 101
  }
  if (minI < maxI) {
    below[i] = as.numeric(1)
    loss[i] = as.numeric(1)
    profit[i] = as.numeric(-50000)
    days[i] = minI
  } else if (maxI < minI) {
    above[i] = as.numeric(1)
    profit[i] = as.numeric(100000)
    loss[i] = as.numeric(0)
    days[i] = maxI
  } else {
    loss[i] = as.numeric(logPrice[100] < log(1e6))
    profit[i] = as.numeric(exp(logPrice[100])-1e6)
    days[i] = 100
  }
}
mean(below) # Likelihood of 50000$ loss
mean(above) # Likelihood of 100000$ profit
mean(loss) # Probability of loss
mean(profit) # Expected profit
roi = rep(0,niter)
for (i in 1:niter) {
  roi[i] = ((profit[i]+1e6)/1e6)^(1/days[i])
}
mean(roi) # Return on investment

##########################
# Geometric random walks #
##########################

set.seed(2012)
n = 253
par(mfrow=c(3,3))
for (i in (1:9))
{
  logr = rnorm(n,0.05/253,0.2/sqrt(253))
  price = c(120,120*exp(cumsum(logr)))
  plot(price,type="l")
}
