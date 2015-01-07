class SearchController < ApplicationController
require 'rubygems'
	require 'ruby-tmdb3'
	require 'rest_client'



	# setup your API key
	Tmdb.api_key = "20c4c7eb600624da5fa682498ce2ca33"
	api_key = "20c4c7eb600624da5fa682498ce2ca33"
	# setup your default language
	Tmdb.default_language = "fr"
	default_language = "fr"
	
	# 4.times { |i| @film << i }


	def self.index
	end
  def index
    headers = {
		:accept => 'application/json'
		}

	@response = RestClient.get 'http://private-anon-e2e5a6b1f-themoviedb.apiary-mock.com/3/movie/top_rated' , headers
	
	
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
    @bandeA = Array.new
	@a = 0
	@filmSearch = Array.new
	@test = params["search"] 
	@result = TmdbMovie.find(:title => params["search"], :limit => 5, :expand_results => true)
	@result.each do |f|
		@filmSearch << f
	end
	
	@filmSearch.each do |bo|
		@b = 0
		@debut_key = 0
		@response = RestClient.get 'http://api.themoviedb.org/3/movie/' + bo.id.to_s + '/videos?language=fr&api_key=20c4c7eb600624da5fa682498ce2ca33'	
		@debut_key = @response.split('"')
		if @debut_key.length == 5
			@response2 = RestClient.get 'http://api.themoviedb.org/3/movie/' + bo.id.to_s + '/videos?api_key=20c4c7eb600624da5fa682498ce2ca33'
			@debut_key = @response2.split('"')
			if @debut_key.length == 5
				@bandeA << "nope"
			else
				@bandeA << @debut_key[15]
			end
		else
			@bandeA << @debut_key[15]
		end
	end
	# format.html { redirect_to(@search,:result => 'Post was successfully created.') }
  end
end
