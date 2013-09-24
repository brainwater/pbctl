class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :album
      t.string :art
      t.string :station
      t.integer :rating
      t.string :detail

      t.timestamps
    end
  end
end
