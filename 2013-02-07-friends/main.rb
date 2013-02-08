require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'


get '/' do
  erb :home
end



get '/add' do
  erb :add
end



get '/friends' do
  sql = "select * from friends"
  @rows = run_sql(sql)

  # how do we test to see contents of @rows?

  erb :friends

end

post '/create' do
  name = params[:name]
  age = params[:age]
  gender = params[:gender]
  image = params[:image]
  twitter_name = params[:twitter_name]
  github_name = params[:github_name]
  sql = "insert into friends (name, age, gender, image, twitter_name, github_name) values ('#{name}', '#{age}', '#{gender}', '#{image}', '#{twitter_name}', '#{github_name}')"
  run_sql(sql)
  redirect to('/')
end

def run_sql(sql)
  conn = PG.connect(:dbname =>'friends_app', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end