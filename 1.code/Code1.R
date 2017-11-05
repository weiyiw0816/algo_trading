library("fBasics", lib.loc="C:/Users/wangw/Downloads/Rpackage")
setwd("C:/Users/wangw/Downloads/Github/algo_trading/0.data")

da=read.csv("xiv_30min3.csv",header = T)
library("plyr")
test=ddply(da, .(day), function(x) x[c(1, nrow(x)), ])
test1 = test[order(as.Date(test$day, format="%m/%d/%Y")),]

#select row 1 for each group
merge1 = test1[ !duplicated(test1$day), ]
myvars <- c("day", "close","Rt_gap")
merge1 <- merge1[myvars]
colnames(merge1)[2] <- "start"
colnames(merge1)[3] <- "gapupdown"

merge2 = ddply(test1, "day", function(z) tail(z,1))
merge2 = merge2[order(as.Date(merge2$day, format="%m/%d/%Y")),]
myvars <- c("day", "close")
merge2 <- merge2[myvars]
colnames(merge2)[2] <- "end"

#merge back to da
da1 = merge(x = da, y = merge1, by = "day", all.x = TRUE)
da1 = merge(x = da1, y = merge2, by = "day", all.x = TRUE)
da1 = da1[order(as.Date(da1$day, format="%m/%d/%Y")),]


#calculate intra_day return
da1$rtn = (da1$end-da1$start)/da1$start
basicStats(da1$rtn)
hist(da1$rtn)

#######################################
#######################################
#intra-day return - gap up analysis
incre <- da1[ which(da1$gapupdown>=0), ]
basicStats(incre$rtn)
hist(incre$rtn)
hist(incre$gapupdown)

#if (incre$rtn < (-0.04)){incre$bucket='less than -0.04'
#} else if (incre$rtn< (-0.03)){incre$bucket='-0.04~-0.03'
#} else if (incre$rtn< (-0.02)){incre$bucket='-0.03~-0.02'
#} else if (incre$rtn< (-0.01)){incre$bucket='-0.02~-0.01'
#} else if (incre$rtn< 0){incre$bucket='-0.01~0'
#} else if (incre$rtn< 0.01){incre$bucket='0~0.01'
#} else if (incre$rtn< 0.02){incre$bucket='0.01~0.02'
#} else if (incre$rtn< 0.03){incre$bucket='0.02~0.03'
#} else if (incre$rtn< 0.04){incre$bucket='0.03~0.04'
#} else {incre$bucket='over 0.04'}

#if gap up by X, the distribution of intraday return
incre1 <- incre[ which(incre$gapupdown<=0.005), ]
basicStats(incre1$rtn)
hist(incre1$rtn)
incre1 <- incre[ which((incre$gapupdown>0.005) & (incre$gapupdown<=0.01)), ]
basicStats(incre1$rtn)
hist(incre1$rtn)
incre1 <- incre[ which((incre$gapupdown>0.01) & (incre$gapupdown<=0.015)), ]
basicStats(incre1$rtn)
hist(incre1$rtn)
incre1 <- incre[ which((incre$gapupdown>0.015) & (incre$gapupdown<=0.02)), ]
basicStats(incre1$rtn)
hist(incre1$rtn)
incre1 <- incre[ which(incre$gapupdown>0.02), ]
basicStats(incre1$rtn)
hist(incre1$rtn)

#######################################
#######################################
#intra-day return - gap down analysis
decre <- da1[ which(da1$gapupdown<0), ]
basicStats(decre$rtn)
hist(decre$rtn)
basicStats(decre$gapupdown)
hist(decre$gapupdown)

#if gap up by X, the distribution of intraday return
decre1 <- decre[ which(decre$gapupdown> -0.01), ]
basicStats(decre1$rtn)
hist(decre1$rtn)
decre1 <- decre[ which((decre$gapupdown<= -0.01) & (decre$gapupdown> -0.02)), ]
basicStats(decre1$rtn)
hist(decre1$rtn)
decre1 <- decre[ which((decre$gapupdown<= -0.02) & (decre$gapupdown> -0.03)), ]
basicStats(decre1$rtn)
hist(decre1$rtn)
decre1 <- decre[ which((decre$gapupdown<= -0.03) & (decre$gapupdown> -0.04)), ]
basicStats(decre1$rtn)
hist(decre1$rtn)
decre1 <- decre[ which(decre$gapupdown<= -0.04), ]
basicStats(decre1$rtn)
hist(decre1$rtn)















#add hoc
da <- da[-c(1), ]
dim(da)
return = da[,8]*100
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
m2=arima(return,order = c(4,0,0))
m2

library(ggplot2)
datos=read.csv("xiv_30min3.csv",header = T)
#datos$date1=as.POSIXct(datos[,2], format="%m/%d/%y %H:%M")




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