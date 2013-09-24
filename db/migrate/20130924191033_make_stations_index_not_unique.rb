class MakeStationsIndexNotUnique < ActiveRecord::Migration
  def change
    remove_index(:stations, :index)
  end
end
