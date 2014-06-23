require 'json'
require 'net/http'
require 'date'

class NseFinance

	# this is the base nsefinance.com JSON service URI
	@@base_uri = 'http://nsefinance.com/api/stocks'

	# These are the available keys that the JSON service returns per stock symbol
	# ['high', 'symbol', 'value', 'deals', 'date','low','units','close','open','change']

	# get the full trading day records for all stocks as at closing time
  def self.all_closing_today
  	tmp = Net::HTTP.get( URI(@@base_uri) )
  	JSON.parse(tmp)
  end

  # get closing prices for all the symbols for the trading day
  def self.all_closing_prices_today
  	json_package = Net::HTTP.get( URI(@@base_uri) )
  	day_records = JSON.parse(json_package)

  	result = Array.new
  	day_records.map {|day_record|
  		result << day_record["close"].to_f
  	}
  	result
  end

  # get the full trading day record for the last 5 trading days for a company
  def self.get_tradings(company_name)
  	result = '{"error" : "Invalid company_name"}'

  	if !company_name.nil?
  		url = "#{@@base_uri}/#{company_name.upcase}"
  		tmp = Net::HTTP.get( URI(url) )
  		result = JSON.parse(tmp)
  	end
  	result
  end

  # get the closing price for the last 5 trading days for a symbol
  def self.latest_closing_prices(company_name)
  	result = ''

  	records = NseFinance.get_tradings(company_name)
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
  def self.trading_details(company_name, date)

  	# check if the date is in the proper format: YYYY-MM-dd
  	parsed_date = nil
  	begin  
	 		parsed_date = Date.parse(date)
	  rescue  
	    result = '{"error" : "Invalid date"}'
	  end

  	if !company_name.nil? && !parsed_date.nil?
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
  def self.closing_price(company, date)
		result = ''

  	record = NseFinance.trading_details(symbol, date)
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