class ListeController < ApplicationController
	def index
		@filmListe = Array.new
		@checked = Array.new
		@maListe = Array.new
		@idcheck = 0
		i = 0
		@maListe = Liste.connection.select_all("SELECT id_film , checked FROM listes WHERE id_user = ' #{current_user.id}'")
		@maListe.each do 
			@filmListe <<  TmdbMovie.find(:id => @maListe[i]["id_film"] , :limit => 1)
			@checked << @maListe[i]["checked"]
			i +=1
		end
	end
	
	def vu
	    Liste.connection.execute("UPDATE `listes` SET `checked`=true WHERE id_user = '#{current_user.id}' AND id_film = '#{params[:id]}' ")
		# @@message = "Vous venez de marquer un film vu"
		redirect_to controller: "/liste", action: "index"
	end
	
	
	def delete
	    Liste.connection.execute("DELETE FROM listes WHERE id_user = '#{current_user.id}' AND id_film = '#{params[:id]}' ")
		# @@message = "Le film a bien été supprimé de votre liste"
		redirect_to controller: "/liste", action: "index"
	end
	
	def add
		addListe = {:id_user => current_user.id, :id_film => params[:id], :checked => false}
		@liste = Liste.new(addListe)
		@liste.save
		# @@message = "Le film a bien été ajouté à votre liste"
		redirect_to controller: "/liste", action: "index"
	end
end
