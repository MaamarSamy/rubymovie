class SearchController < ApplicationController
require 'rubygems'
	require 'ruby-tmdb3'

	# setup your API key
	Tmdb.api_key = "20c4c7eb600624da5fa682498ce2ca33"

	# setup your default language
	Tmdb.default_language = "fr"
	
	# 4.times { |i| @film << i }


	def self.index
	end
  def index
  
	@film = Array.new
	@movie = TmdbMovie.find(:title => "Iron", :limit => 3)

	@movie.each do |f|
		@film << f
	end
  end
  
  def result
	@filmSearch = Array.new
	@test = params["search"] 
	@result = TmdbMovie.find(:title => params["search"], :limit => 10)
	@result.each do |f|
		@filmSearch << f
	end
	
	# format.html { redirect_to(@search,:result => 'Post was successfully created.') }
  end
end
