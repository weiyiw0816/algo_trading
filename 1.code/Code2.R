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
#a)if the lowest price in the first 90min lower or higher than the previous day lowest (by at least 1 cent), what is the return for the rest of day
#previous day lowest price
merge3 = aggregate(close ~ day, da1, function(x) min(x))
merge3 = merge3[order(as.Date(merge3$day, format="%m/%d/%Y")),]
library(DataCombine)
merge3 <- slide(merge3, Var = "close", slideBy = -1)
merge3 = merge3[,-2]
colnames(merge3)[2] <- "min_previous"

#first 90min for each day - get min of 4 obs for each group
require(data.table)
merge4 <- data.table(da1, key="day")
merge4 = merge4[, head(.SD, 4), by=day]
merge4 = merge4[order(as.Date(merge4$day, format="%m/%d/%Y")),]
merge4 = aggregate(close ~ day, merge4, function(x) min(x))
merge4 = merge4[order(as.Date(merge4$day, format="%m/%d/%Y")),]
colnames(merge4)[2] <- "min_90"



#return for the rest of day
#rows = rownames(merge4)
merge5 <- data.table(da1, key="day")
merge5 = merge5[, tail(.SD, 9), by=day]
merge5 = merge5[order(as.Date(merge5$day, format="%m/%d/%Y")),]
###################
test = merge5[ !duplicated(merge5$day), ]
test <- test[ ,c("day", "close")]
colnames(test)[2] <- "start90"

test2 = ddply(merge5, "day", function(z) tail(z,1))
test2 = test2[order(as.Date(test2$day, format="%m/%d/%Y")),]
myvars <- c("day", "close")
test2 <- test2[myvars]
colnames(test2)[2] <- "end90"

#merge back 1)the rest other than 90min in 1day
da2 = merge(x = da1, y = test, by = "day", all.x = TRUE)
da2 = merge(x = da2, y = test2, by = "day", all.x = TRUE)
da2 = da2[order(as.Date(da2$day, format="%m/%d/%Y")),]

#merge back 1)previous day lowest 2)min of first 90day
da2 = merge(x = da2, y = merge3, by = "day", all.x = TRUE)
da2 = merge(x = da2, y = merge4, by = "day", all.x = TRUE)
da2 = da2[order(as.Date(da2$day, format="%m/%d/%Y")),]

###########################
###########################
#calculate intra_day return
da2$rtn90 = (da2$end90-da2$start90)/da2$start90

#if condition and distribution
con1 <- da2[ which(da2$min_90 < 0.99*da2$min_previous), ]
basicStats(con1$rtn90)
hist(con1$rtn90)

con1 <- da2[ which(da2$min_90 > 1.01*da2$min_previous), ]
basicStats(con1$rtn90)
hist(con1$rtn90)










#######################################
#######################################
#b. if the highest price in the first 90max higher than the previous day Highest (by at least 1 cent), what is the return for the rest of day
merge5 = aggregate(close ~ day, da2, function(x) max(x))
merge5 = merge5[order(as.Date(merge5$day, format="%m/%d/%Y")),]
library(DataCombine)
merge5 <- slide(merge5, Var = "close", slideBy = -1)
merge5 = merge5[,-2]
colnames(merge5)[2] <- "max_previous"

#first 90max for each day - get min of 4 obs for each group
require(data.table)
merge6 <- data.table(da2, key="day")
merge6 = merge6[, head(.SD, 4), by=day]
merge6 = merge6[order(as.Date(merge6$day, format="%m/%d/%Y")),]
merge6 = aggregate(close ~ day, merge6, function(x) max(x))
merge6 = merge6[order(as.Date(merge6$day, format="%m/%d/%Y")),]
colnames(merge6)[2] <- "max_90"

#merge back 1)previous day highest 2)max of first 90day
da3 = merge(x = da2, y = merge5, by = "day", all.x = TRUE)
da3 = merge(x = da3, y = merge6, by = "day", all.x = TRUE)
da3 = da3[order(as.Date(da3$day, format="%m/%d/%Y")),]


#if condition and distribution
con2 <- da3[ which(da3$max_90 < 0.99*da3$max_previous), ]
basicStats(con2$rtn90)
hist(con2$rtn90)

con2 <- da3[ which(da3$max_90 > 1.01*da3$max_previous), ]
basicStats(con2$rtn90)
hist(con2$rtn90)






