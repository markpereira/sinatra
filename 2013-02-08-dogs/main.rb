require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'pg'

before do
  sql = "select distinct breed from dogs"
  @nav_rows = run_sql(sql)
end

#------ EDIT FUNCTIONS

get '/dogs/:dog_id/edit' do
  sql = "select * from dogs where id = #{params['dog_id']}"
  rows = run_sql(sql)
  @row = rows.first
  erb :new
end

post '/dogs/:dog_id' do
  sql = "update dogs set name = '#{params['name']}', breed = '#{params['breed']}', photo = '#{params['photo']}' where id = #{params['dog_id']}"
  run_sql(sql)
  redirect to('/dogs')
end


#-------DELETE FUNCTION
# the dog
post '/dogs/:dog_id/delete' do
  sql = "delete from dogs where id = #{params['dog_id']} "
  run_sql(sql)
  redirect to('/dogs')
end

#------ GET ALL DOGS OF A PARTICULAR BREED
get '/dogs/:breed' do
  sql = "select * from dogs where breed = '#{params['breed']}'"
  @rows = run_sql(sql)
  erb :dogs
end



get '/' do
  erb :home
end

get '/new' do
  erb :new
end

get '/dogs' do
  sql = "select * from dogs"
  @rows = run_sql(sql)
  erb :dogs
end



# inserts form data into database
post '/create' do

  @name = params[:name]
  @photo = params[:photo]
  @breed = params[:breed]

  sql = "insert into dogs (name, photo, breed) values ('#{@name}', '#{@photo}', '#{@breed}')"
  run_sql(sql)

  redirect to('/dogs')

end

def run_sql(sql)
  conn = PG.connect(:dbname =>'dogsdb', :host => 'localhost')
  result = conn.exec(sql)
  conn.close

  result
end