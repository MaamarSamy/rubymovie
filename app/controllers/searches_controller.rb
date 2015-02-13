class SearchesController < ApplicationController
	
	
	require 'rubygems'
	# require 'ruby-tmdb3'
	require 'rest_client'
	Tmdb.api_key = "20c4c7eb600624da5fa682498ce2ca33"
	Tmdb.default_language = "fr"

	def self.index
	end

	def index
		@title = 'Popular Movies'
		@ma_liste = current_user.listes
		@response = RestClient.get 'http://api.themoviedb.org/3/movie/popular?language=fr&api_key=20c4c7eb600624da5fa682498ce2ca33&page=1'
		@popular = JSON.parse(@response)
	end

	def result

		@bande_annonce = Array.new
		@a = 0
		@result_search = Array.new
		@result = TmdbMovie.find(:title => params["search"], :limit => 10, :expand_results => true)
		@result.each do |f|
			@result_search << f
		end
		
		@result_search.each do |bo|
			@debut_key = 0
			@response = RestClient.get 'http://api.themoviedb.org/3/movie/' + bo.id.to_s + '/videos?language=fr&api_key=20c4c7eb600624da5fa682498ce2ca33'	
			@debut_key = @response.split('"')
			if @debut_key.length == 5
				@response2 = RestClient.get 'http://api.themoviedb.org/3/movie/' + bo.id.to_s + '/videos?api_key=20c4c7eb600624da5fa682498ce2ca33'
				@debut_key = @response2.split('"')
				if @debut_key.length == 5
					@bande_annonce << "nope"
				else
					@bande_annonce << @debut_key[15]
				end
			else
				@bande_annonce << @debut_key[15]
			end
		end
	end	
  
	def infos
		response = RestClient.get'http://api.themoviedb.org/3/movie/'+params[:id]+'?language=fr&api_key=20c4c7eb600624da5fa682498ce2ca33' 
		parse = JSON.parse(response)
	end
end
