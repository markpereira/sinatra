require 'pry'
require 'JSON'
require 'HTTParty'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

get '/' do
  if !params[:title].nil?

    # user input modified and put into variable
    @title = params[:title].chomp
    @description = params[:description].chomp

    sql = "insert into todo (title, description, completed) values ('#{@title}', '#{@description}', 'false');"


    conn = PG.connect(:dbname =>'todo_app', :host => 'localhost')
    conn.exec(sql)
    conn.close

    erb :home
  else
    erb :home
  end
end





get '/' do
  sql = "select * from todo;"
  @rows = run_sql(sql)
  erb :home
end



def run_sql(sql)
    conn = PG.connect(:dbname =>'todo_app', :host => 'localhost')
    result=conn.exec(sql)
    conn.close

    result
end

post '/create' do
  item = params['items']
  details = params['details']
  sql = "insert x into y"
  run_sql(sql)
  redirect to('/')





# BASIC LINKS -----------------------------

get '/addnew' do
  erb :addnew
end

get '/' do
  erb :home
end

get '/faq' do
  erb :faq
end

get '/about' do
  erb :about
end

# -----------------------------------------