require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

# get '/calc/add/:x/:y' do
#   @result = params[:x].to_i + params[:y].to_i
#   @operator = '+'
#   erb :calc
# end
  get '/stock' do
    if !params[:name].nil?
      @name = params[:name]
      @get_price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @name)[@name].lastTrade
      erb :stock
    else
      erb :stock
    end
  end
