class Movies < ActiveRecord::Migration
  def change
  	change_table :movies do |t|
  		t.column :id_tmdb, :integer
  	end
  end
end
