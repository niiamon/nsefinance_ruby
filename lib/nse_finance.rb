require 'json'
require 'net/http'
require 'Date'

class NseFinance

	# this is the base nsefinance.com JSON service URI
	@@base_uri = 'http://nsefinance.com/api/stocks'

	# These are the available keys that the JSON service returns per stock symbol
	# ['high', 'symbol', 'value', 'deals', 'date','low','units','close','open','change']

  # get closing prices for all the symbols for the trading day
  def self.all_closing_today
  	tmp = Net::HTTP.get( URI(@@base_uri) )
  	JSON.parse(tmp)
  end

  # get the full trading day record for the last 5 trading days for a symbol
  def self.symbol(symbol)
  	result = '{"error" : "Invalid symbol"}'

  	if !symbol.nil?
  		url = "#{@@base_uri}/#{symbol.upcase}"
  		tmp = Net::HTTP.get( URI(url) )
  		result = JSON.parse(tmp)
  	end
  	result
  end

  # get the closing price for the last 5 trading days for a symbol
  def self.symbol_closing_prices(symbol)
  	result = ''

  	records = NseFinance.symbol(symbol)
  	if records.include?("error")
  		result = records
  	else
  		result = Array.new
  		records.map { |day_record|
  			result << day_record["close"].to_f
  		}
  	end
  	result
  end

  # get the full trading day record for a particular symbol on a particular day
  def self.symbol_on(symbol, date)

  	# check if the date is in the proper format: YYYY-MM-dd
  	parsed_date = nil
  	begin  
	 		parsed_date = Date.parse(date)
	  rescue  
	    result = '{"error" : "Invalid date"}'
	  end

  	if !symbol.nil? && !parsed_date.nil?
  		url = "#{@@base_uri}/#{symbol.upcase}/#{date}"
  		tmp = Net::HTTP.get( URI(url) )

  		if tmp.include?("error")
  			result = '{"error" : "Invalid symbol"}'
  		else
  			tmp_result = JSON.parse(tmp)
  			result = tmp_result
  			if tmp_result.length > 1
  				result = '{"error" : "Invalid date"}'
  			end
  		end
  	end

  	result
  end

  # get the closing price for a particular symbol on a particular day
  def self.symbol_closing_price_on(symbol, date)
		result = ''

  	record = NseFinance.symbol_on(symbol, date)
  	if record.include?("error")
  		result = record
  	elsif record.empty?
  		result = '{"response": "No data"}'
  	else
  		result = record["#{symbol}"]["close"]
  	end
  	result
  end

end