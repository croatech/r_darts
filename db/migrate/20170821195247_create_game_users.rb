class CreateGameUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :game_users do |t|
      t.references :game, null: false
      t.references :user, null: false
    end
  end
end
