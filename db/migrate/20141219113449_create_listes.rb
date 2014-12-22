class CreateListes < ActiveRecord::Migration
  def change
    create_table :listes do |t|
      t.integer :id_user
      t.integer :id_film
      t.boolean :checked

      t.timestamps
    end
  end
end
