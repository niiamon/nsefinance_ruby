Ruby interface to nsefinance.com
===============
## Getting started

Add it to your Gemfile with:

```ruby

gem 'nse_finance'

Run the bundle command to install it.

require nse_finance

# available keys for trading day records:
# ['high', 'symbol', 'value', 'deals', 'date','low','units','close','open','change']



# get only closing prices for all the symbols for the trading day
NseFinance.all_closing_prices_today
# will return an array such as:
[82.64, 0.92, 8.15, 3.21, 1.75, 0.85, 2.85, 5.3, 17.97, ...]




# get the full trading day records for all stocks as at closing time
NseFinance.all_closing_today

# will return an array such as:
[{"deals"=>"0", "symbol"=>"7UP", "value"=>"2,302,377.65", "high"=>"82.64", "units"=>"26,715", "low"=>"82.64", "date"=>"14/Feb/2014", "close"=>"82.64", "open"=>"82.64", "change"=>"0.00"}, {"deals"=>"0", "symbol"=>"ABCTRANS", "value"=>"11,352.00", "high"=>"0.92", "units"=>"12,900", "low"=>"0.92", "date"=>"14/Feb/2014", "close"=>"0.92", "open"=>"0.92", "change"=>"0.00"}, ...]




# get the full trading day record for the last 5 trading days for a particular symbol
NseFinance.get_tradings('OANDO')

# will return 
[{"deals"=>"0", "symbol"=>"OANDO", "value"=>"151,898,174.40", "high"=>"19.21", "units"=>"8,273,024", "low"=>"18.16", "date"=>"14/Feb/2014", "close"=>"18.2", "open"=>"19.11", "change"=>"(0.91)"}, {"deals"=>"0", "symbol"=>"OANDO", "value"=>"190,652,316.90", "high"=>"20.95", "units"=>"9,422,433", "low"=>"19.82", "date"=>"13/Feb/2014", "close"=>"20.04", "open"=>"20.8", "change"=>"(0.76)"}, {"deals"=>"0", "symbol"=>"OANDO", "value"=>"88,941,656.77", "high"=>"20.7", "units"=>"4,366,931", "low"=>"20.17", "date"=>"12/Feb/2014", "close"=>"20.6", "open"=>"20.99", "change"=>"(0.39)"}, {"deals"=>"0", "symbol"=>"OANDO", "value"=>"96,953,945.47", "high"=>"21", "units"=>"4,670,001", "low"=>"20.67", "date"=>"11/Feb/2014", "close"=>"20.67", "open"=>"21.75", "change"=>"(1.08)"}, {"deals"=>"0", "symbol"=>"OANDO", "value"=>"243,724,958.80", "high"=>"21.8", "units"=>"11,540,129", "low"=>"20.81", "date"=>"10/Feb/2014", "close"=>"20.81", "open"=>"21.9", "change"=>"(1.09)"}]
# if the symbol is not one of the symbols on the list, will return:
{"error"=>"Invalid symbol"}

# if you want only the closing prices for a symbol for the last 5 trading days
NseFinance.latest_closing_prices('OANDO')

# will return
[18.2, 20.04, 20.6, 20.67, 20.81]
# if the symbol is not valid, you will receive an error:
{"error" : "Invalid symbol"}




# get the full trading day record for a particular symbol on a particular day
NseFinance.trading_details('OANDO', '2014-02-10')

# will return
{"OANDO"=>{"deals"=>"0", "symbol"=>"OANDO", "value"=>"243,724,958.80", "high"=>"21.8", "units"=>"11,540,129", "low"=>"20.81", "date"=>"10/Feb/2014", "close"=>"20.81", "open"=>"21.9", "change"=>"(1.09)"}}

# if the symbol is not valid, you will receive an error:
{"error" : "Invalid symbol"}
# same for an invalid date (according to Date.parse)
{"error" : "Invalid date"}
# if there is no data for the data you want, you will receive an empty object
{}

# if you want only the closing price for a particular symbol on a particular day
NseFinance.closing_price('OANDO', '2014-02-10')
```

Full documentation of for the api is available at [http://nsefinance.com/docs](http://nsefinance.com/docs)

Other libraries:
- Python: https://github.com/cyberomin/NSEFinance-Python
- PHP: https://github.com/cyberomin/NSEFinance-PHP