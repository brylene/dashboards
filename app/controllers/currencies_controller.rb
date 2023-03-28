class CurrenciesController < ApplicationController
  def first_currency
   @raw_data = open("https://api.exchangerate.host/symbols").read
   @parsed_data = JSON.parse(@raw_data)
   @symbols_hash = @parsed_data.fetch("symbols")
  
   @array_of_symbols = @symbols_hash.keys
    render({ :template => "currency_templates/step_one.html.erb" })
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    # params are
    # Parameters: {"from_currency" =>"ARS"}

    @from_symbol = params.fetch("from_currency")
    render({ :template => "currency_templates/step_two.html.erb"})
  end

  def third_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    # params are
    # Parameters: {"from_currency" =>"ARS"}

    @from_symbol = params.fetch("from_currency")
    @to_currency = params.fetch("to_currency")
    @rate_data = open("https://api.exchangerate.host/convert?from=#{@from_symbol}&to=#{@to_currency}").read
    @parsed_rate = JSON.parse(@rate_data)
    @currency = @parsed_rate.fetch("query")
    @rate = @parsed_rate.fetch("info")

    @rate = @rate.fetch("rate")

    render({ :template => "currency_templates/step_three.html.erb"})
  end
end
