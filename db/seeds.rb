# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'


url = 'http://tmdb.lewagon.com/movie/top_rated?api_key=<your_api_key>'
movie_serialized = URI.open(url).read
movie_parsed = JSON.parse(movie_serialized)

Movie.delete_all
puts "Starting..."

movies = movie_parsed["results"]

movies.each do |movie|
  @movie = Movie.new
  @movie.title = movie["original_title"]
  @movie.overview = movie["overview"]
  @movie.rating = movie["vote_average"]
  @movie.poster_url = movie["poster_path"]

  @movie.save!
end

p "all movies created"
List.delete_all
p "Creating lists"
 lists = ['Drama', 'Love story', 'Horror', 'Thriller', 'Comedy']

 lists.each_with_index do |genre, index|
  @list = List.create(name: genre).save!
  "Creating list #{index}"
 end

 p "Created all lists"
