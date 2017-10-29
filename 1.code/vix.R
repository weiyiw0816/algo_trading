library("fBasics", lib.loc="C:/Users/wangw/Downloads/Rpackage")
da=read.csv("vix_hourly1.csv",header = T)
da <- da[-c(1), ]
dim(da)
return = da[,3]*100
log_rt = log(da[,3]+1)*100

#simple return
basicStats(return)
plot(return, type='l',ylab="vix Returns")
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


#log return
basicStats(log_rt)
plot(log_rt, type='l',ylab="vix Returns")
s1=skewness(log_rt)
t1=s1/sqrt(6/nrow(da))
pv=2*(1-pnorm(t1))
t1
pv
t.test(log_rt)

normalTest(log_rt,method = 'jb')
plot(log_rt,type='l')
acf(log_rt,lag=10)
Box.test(log_rt,lag=5,type='Ljung')

m1=ar(log_rt,method = "mle")
m1$order
m2=arima(log_rt,order = c(2,0,0))
m2