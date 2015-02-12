class ListesController < ApplicationController
	def index
 		@title = 'My film list'
		@filmListe = Array.new
        @filmListe2 = Array.new
        @checked = Array.new
        @maListe = Array.new
        @idcheck = 0
        i = 0
        @maListe = current_user.listes
        p @maListe
        # @maListe.each do 
        # 	@filmListe2 << Liste.connection.select_all("SELECT id_tmdb, description, name FROM movies WHERE id_tmdb = '#{@maListe[i]["id_film"]}'")

        #     #@filmListe2 <<  JSON.parse( RestClient.get 'http://api.themoviedb.org/3/movie/' + @maListe[i]["id_film"].to_s + '?language=fr&api_key=20c4c7eb600624da5fa682498ce2ca33')
        #     #@filmListe << TmdbMovie.find(:id => @maListe[i]["id_film"] , :limit => 1)
        #     @checked << @maListe[i]["checked"]
        #     i +=1
        # end
	end
	
	def vu
	    Liste.connection.execute("UPDATE `listes` SET `checked`=true WHERE id_user = '#{current_user.id}' AND id_film = '#{params[:id]}' ")
		# @@message = "Vous venez de marquer un film vu"
		redirect_to controller: "/listes", action: "index"
	end
	
	
	def delete
	    # Liste.connection.execute("DELETE FROM listes WHERE user_id = '#{current_user.id}' AND id_film = '#{params[:id]}' ")

	    current_user.listes.where(:movie_id=>params[:id]).first.delete
		# @@message = "Le film a bien été supprimé de votre liste"
		redirect_to controller: "/listes", action: "index"
	end
	
	def add
		addListe = {:user_id => current_user.id, :movie_id => params[:id], :checked => false}
		@liste = Liste.new(addListe)
		@liste.save

		if (!Movie.where(id_tmdb:params[:id]).exists?)
			# Recuperer infos du film/ enregistrer le film en base
			response = RestClient.get'http://api.themoviedb.org/3/movie/'+params[:id]+'?language=fr&api_key=20c4c7eb600624da5fa682498ce2ca33' 
			parse = JSON.parse(response)

			@description = parse['overview']
			@image = parse['poster_path']
			@name = parse['title']

			addMovie = {:id_tmdb => params[:id], :name => @name, :image => @image, :description => @description}
			@movies = Movie.new(addMovie)
			@movies.save


		end
movie=Movie.where(id_tmdb:params[:id]).first
			@liste.update_attributes(:movie_id => movie.id)
		# @@message = "Le film a bien été ajouté à votre liste"
		redirect_to controller: "/listes", action: "index"
	end
end
