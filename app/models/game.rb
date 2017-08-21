class Game < ApplicationRecord
  validates :score, :status, presence: true
  validates :status, uniqueness: true

  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id', optional: true

  enum status: %i[active finished]

  has_many :game_users, dependent: :destroy
end
