class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :remember_token
      t.integer :user_id

      t.timestamps
    end
    add_index :sessions, [:remember_token,]
  end
end
