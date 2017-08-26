class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :game_users
  has_many :games, through: :game_users
  has_many :rounds, through: :games
end
