# algo_trading
# week of 10/23: 1) data analysis code for return in R; 2) label date for each data point; 3) intra-quarter analysis - data preparation, distribution analysis for gap up or gap down, bucket analysis in excel

Basic definitions:
1. Gap up (down):  X(D+1)_open/X(D)_close > 1 where X_open is the stock OPEN price at a certain time and D stands for Day
2. Intraday day return for time t: [(X(D)_T+t - X(D)_T) / X(D)_T]


Code XXXX1 is to analyze data for intraday patterns under Gap up or down conditions: if it's gapped up (or down) by X at day D, what is the distribution Y of intraday return?  

Code XXXX2 calculates intraday patterns under the first 2 trading hours: (identify lowest or highest price within certain time frame)

a. if the lowest price in the first 90min lower or higher than the previous day lowest (by at least 1 cent), what is the return for the rest of day

b. if the highest price in the first 90min higher than the previous day Highest (by at least 1 cent), what is the return for the rest of day

c. ....
