class SearchController < ApplicationController
require 'rubygems'
	require 'ruby-tmdb3'
	require 'rest_client'



	# setup your API key
	Tmdb.api_key = "20c4c7eb600624da5fa682498ce2ca33"

	# setup your default language
	Tmdb.default_language = "fr"
	
	# 4.times { |i| @film << i }


	def self.index
	end
  def index
    headers = {
		:accept => 'application/json'
		}

	# @response = RestClient.get 'http://private-anon-2b576ff3e-themoviedb.apiary-mock.com/3/movie/popular' , headers
	
	
	@film = Array.new
	@movie = TmdbMovie.find(:title => "Seigneur", :limit => 3)

	@movie.each do |f|
		@film << f
	end
  end
  
  def result
	@dejadansListe = Array.new
	i = 0
	@maListe = Liste.connection.select_all("SELECT id_film FROM listes WHERE id_user = ' #{current_user.id}'")
	@maListe.each do 
		@dejadansListe <<  @maListe[i]["id_film"]
		i += 1
	end
  
	@filmSearch = Array.new
	@test = params["search"] 
	@result = TmdbMovie.find(:title => params["search"], :limit => 10)
	@result.each do |f|
		@filmSearch << f
	end
	
	# format.html { redirect_to(@search,:result => 'Post was successfully created.') }
  end
end
