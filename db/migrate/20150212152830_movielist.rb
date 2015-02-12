class Movielist < ActiveRecord::Migration
  def change
  		rename_column :listes, :id_user, :user_id
  		rename_column :listes, :id_film, :movie_id
  end
end
