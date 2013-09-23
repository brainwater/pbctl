class AddIndexToStationsName < ActiveRecord::Migration
  def change
    add_index :stations, :name, unique: true
  end
end
