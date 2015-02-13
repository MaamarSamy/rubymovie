class ListesController < ApplicationController
	def index
	
 		@title = 'My film list'
        @ma_liste = Array.new
        @ma_liste = current_user.listes
	end
	
	def vu
	
		current_user.listes.where(movie_id:params[:id]).first.update_attributes(:checked => true)
		redirect_to controller: "/listes", action: "index"
	end
	
	
	def delete
	
	    current_user.listes.where(:movie_id=>params[:id]).first.delete
		redirect_to controller: "/listes", action: "index"
	end
	
	def add
	
		movie = Movie.where(id_tmdb:params[:id])
		if (movie.empty?)
			parse = JSON.parse(RestClient.get'http://api.themoviedb.org/3/movie/'+params[:id]+'?language=fr&api_key=20c4c7eb600624da5fa682498ce2ca33')
			movies = Movie.new({:id_tmdb => params[:id], :name => parse['title'], :image => parse['poster_path'], :description => parse['overview']})
			movies.save
		end
		
		movie = Movie.where(id_tmdb:params[:id]).first
		if(current_user.listes.where(movie_id:movie.id).first == nil)
			liste = Liste.new({:user_id => current_user.id, :movie_id => params[:id], :checked => false})
			liste.save
			liste.update_attributes(:movie_id => movie.id)
		end
		
		redirect_to controller: "/listes", action: "index"
	end
end
