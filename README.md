# algo_trading

Basic definitions:
1. Gap up (down):  X(D+1)_open/X(D)_close > 1 where X_open is the stock OPEN price at a certain time and D stands for Day
2. Intraday day return for time t: [(X(D)_close_T+t - X(D)_open_T) / X(D)_open_T]

measurement for each slide: 
1)rtn frequency of ratio of positive over negative
2)calculate average rtn of positive & negative
3)calculate sharpe - rtn/volatility (std of intra day return)

# week of 10/23: 

Code XXXX1 is to analyze data for intraday patterns under Gap up or down conditions: if it's gapped up (or down) by X at day D, what is the distribution Y of intraday return?  

Code XXXX2 calculates intraday patterns under the first 2 trading hours: (identify lowest or highest price within certain time frame)

a. if the lowest price in the first 90min lower or higher than the previous day lowest (by at least 1 cent), what is the return for the rest of day

b. For each day, if the highest price in the first 90min is higher than the previous day Highest (by at least 1 cent), what is the return for the rest of the day

conclusion: not to trade at gap down, gap up buy scenario 1&5
gap up advantage: minimize risk - aviod big volatility

# take away of 10/23:
1) put mean median std min max
2) change 1 percent to 1 cent, change close price to open price
3) Under Gap up: not (if the lowest price in the first 90min lower than the previous day lowest (by at least 1 cent), what is the return for the rest of day)
4) Under Gap up: not (if the lowest price in the first 30min lower than the previous day lowest (by at least 1 cent), what is the return for the rest of day)



# December projects
1)try out Robin auto-trading
2)make connection with VIX (read more VIX & XIV)
XIV is driven by 2 competing force - 1 movement of vix index itself 2 curve of vix future
3)R-shiny implementation
