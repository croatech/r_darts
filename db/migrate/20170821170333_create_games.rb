class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :score, null: false
      t.integer :winner_id
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
