# algo_trading

Basic definitions:
1. Gap up (down):  X(D+1)_open/X(D)_close > 1 where X_open is the stock OPEN price at a certain time and D stands for Day
2. Intraday day return for time t: [(X(D)_close_T+t - X(D)_open_T) / X(D)_open_T]

measurement for each slide: 
1. rtn frequency of ratio of positive over negative
2. calculate average rtn of positive & negative
3. calculate sharpe - rtn/volatility (std of intra day return)

# week of 10/23: 

Code XXXX1 is to analyze data for intraday patterns under Gap up or down conditions: if it's gapped up (or down) by X at day D, what is the distribution Y of intraday return?  

Code XXXX2 calculates intraday patterns under the first 2 trading hours: (identify lowest or highest price within certain time frame)

a. if the lowest price in the first 90min lower or higher than the previous day lowest (by at least 1 cent), what is the return for the rest of day

b. For each day, if the highest price in the first 90min is higher than the previous day Highest (by at least 1 cent), what is the return for the rest of the day

conclusion: not to trade at gap down, gap up buy scenario 1&5
gap up advantage: minimize risk - aviod big volatility

# take away of 10/23:
1. put mean median std min max
2. change 1 percent to 1 cent, change close price to open price
3. Under Gap up: not (if the lowest price in the first 90min lower than the previous day lowest (by at least 1 cent), what is the return for the rest of day)
4. Under Gap up: not (if the lowest price in the first 30min lower than the previous day lowest (by at least 1 cent), what is the return for the rest of day)

# take away of 11/12/17
con:(needs to be double confirm)
1. gap up: buying at 30min has advantage over buying at open because gap-up scenario1 is positive?
2. gap down within 2%: buy at open and sale at 30min is a good strategy?
because buy at gap-down open has similar return as gap-up (1st week conclude never buy at gap-down - use 30min, this week conclude it's fine to buy at gap-down within 2% use open price)
3. what is the best buying point (lowest price) vs. best selling point (highest price) during intraday?
- calculate intraday returns for time interval of every 30min: i.e., 0-30,30-60, 60-90... (ALL, and gap-up only)
- Find a lowest price of each date and record it as time T, show a distribution of T. Simply mark T=1 if it is within 30min after opening, T=2 if it is 60min after opening, T=3...


# December projects
0.1 what is the best buying point (lowest price) vs. best selling point (highest price) during intra day?

0.2 Code XXXX3 calculates intraday patterns under the last 30min trading in the previous day: 
if it goes up (or down) by X% during the last 30min in the PREVIUS day, (A) what is the intraday return distribution Y of the NEXT day (from day open to day close)  and what is the return distribution Z from the previous day close and the next day close

1. try out IB or Robin auto-trading
2. make connection with VIX (read more VIX & XIV)
- XIV is driven by 2 competing force - 1 movement of vix index itself 2 curve of vix future
http://www.trader1688.com/bb/viewtopic.php?f=5&t=61760&st=0&sk=t&sd=a&sid=9746de8fcfca49dbdbee0279b5f8df20
3. R-shiny implementation

4. https://github.com/T1n9/nasdaq_rank.git
