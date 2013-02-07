require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

# get '/calc/multiply/:x/:y' do
#   @result = params[:x].to_i * params[:y].to_i
#   @operator = 'x'
#   erb :calc
# end

# get '/calc/add/:x/:y' do
#   @result = params[:x].to_i + params[:y].to_i
#   @operator = '+'
#   erb :calc
# end

get '/calc' do
  @first = params['first'].to_f
  @second = params['second'].to_f
  @result = case params[:operator]
  when '+' then @first + @second
  when '-' then @first - @second
  when '*' then @first * @second
  when '/' then @first / @second
  end


  erb :calc
end




# get '/name/:first/:last/:age' do
#   "your name is : #{params[:first]} #{params[:last]} and you are #{params[:age]} years old"
# end

# get '/hello' do
#   'i am a master hacker ninja!!!'
# end

# get '/' do
#   'this is the home page'
# end

# get '/ron' do
#   'Hello Ron.'
# end
