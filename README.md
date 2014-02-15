Ruby interface to nsefinance.com
===============

```ruby

require nse_finance

# available keys for trading day records:
# ['high', 'symbol', 'value', 'deals', 'date','low','units','close','open','change']

# get closing prices for all the symbols for the current trading day
NseFinance.all_closing_today

```

Full documentation of for the api is available at [http://nsefinance.com/docs](http://nsefinance.com/docs)