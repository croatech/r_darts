class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :score, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
