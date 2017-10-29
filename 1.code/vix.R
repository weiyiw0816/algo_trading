library("fBasics", lib.loc="C:/Users/wangw/Downloads/Rpackage")
da=read.csv("vix_hourly1.csv",header = T)
da <- da[-c(1), ]
dim(da)
return = da[,3]*100
basicStats(return)

s1=skewness(return)
t1=s1/sqrt(6/nrow(da))
pv=2*(1-pnorm(t1))
t1
pv
t.test(return)

normalTest(return,method = 'jb')
plot(return,type='l')
acf(return,lag=10)
Box.test(return,lag=5,type='Ljung')

m1=ar(return,method = "mle")
m1$order
m2=arima(return,order = c(7,0,0))
m2
