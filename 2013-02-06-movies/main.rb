require 'pry'
require 'JSON'
require 'HTTParty'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

get '/movie' do
  sql = "select poster from movies"

  conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
  @rows = conn.exec(sql)
  conn.close
  erb :posters

end


get '/' do
  if !params[:film].nil?

    # user input modified and put into variable
    @name = params[:film].chomp.split.join('+')

    # fetch omdb info and put into 'rawdata'
    rawdata = HTTParty.get("http://www.omdbapi.com/?t=#{@name}")

    # convert data to hash called movie_data
    movie_data = JSON(rawdata.body)

    # create var names for select parts of hash
    @title = movie_data["Title"]
    @year = movie_data["Year"]
    @rated = movie_data["Rated"]
    @runtime = movie_data["Runtime"]
    @genre = movie_data["Genre"]
    @director = movie_data["Director"]
    @writer = movie_data["Writer"]
    @actors = movie_data["Actors"]
    @poster = movie_data["Poster"]

    sql = "insert into movies (title, poster, year, director, actors, rated, runtime, genre) values ('#{@title}', '#{@poster}', '#{@year}', '#{@director}', '#{@actors}', '#{@rated}', '#{@runtime}', '#{@genre}');"


    conn = PG.connect(:dbname =>'movie_app', :host => 'localhost')
    conn.exec(sql)
    conn.close

    erb :movie
  else
    erb :home
  end
end


input = gets.chomp.split.join('+')


get '/posters' do
  erb :posters
end

get '/movie' do
  erb :movie
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

