class GameUser < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :game_id, :user_id, presence: true
end
