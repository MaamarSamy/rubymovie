class CreateRecherches < ActiveRecord::Migration
  def change
    create_table :recherches do |t|

      t.timestamps
    end
  end
end
