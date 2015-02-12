class SearchesController < ApplicationController
	
	
  require 'rubygems'
  # require 'ruby-tmdb3'
  require 'rest_client'
  # setup your API key
  Tmdb.api_key = "20c4c7eb600624da5fa682498ce2ca33"
  # api_key = "20c4c7eb600624da5fa682498ce2ca33"
  Tmdb.default_language = "fr"


  def self.index
  end
  
  def index
 	@title = 'Popular Movies'
 	@couleur = 1
	headers = {
		:accept => 'application/json'
	}
	@dejadansList = Array.new
	z = 0
	@maList = Liste.connection.select_all("SELECT movie_id FROM listes WHERE user_id = ' #{current_user.id}'")
	@maList.each do 
		@dejadansList <<  @maList[z]["movie_id"]
		z += 1
	end
	@response = RestClient.get 'http://api.themoviedb.org/3/movie/popular?language=fr&api_key=20c4c7eb600624da5fa682498ce2ca33&page=1'
	# @popular = @response.split('"')
	@test = JSON.parse(@response)
	
	
  end
  
  def result
	@dejadansListe = Array.new
	i = 0
	@maListe = Liste.connection.select_all("SELECT movie_id FROM listes WHERE user_id = ' #{current_user.id}'")
	@maListe.each do 
		@dejadansListe <<  @maListe[i]["movie_id"]
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
	
  end
end
