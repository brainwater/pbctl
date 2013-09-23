class AddIndexToStationsIndex < ActiveRecord::Migration
  def change
    add_index :stations, :index, unique: true
  end
end
