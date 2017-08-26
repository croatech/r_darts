class Game < ApplicationRecord
  validates :score, :status, presence: true

  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id', optional: true

  enum status: %i[active finished]

  has_many :game_users, dependent: :destroy
  has_many :rounds, dependent: :destroy
  has_many :users, through: :game_users

  def current_round
    self.rounds.active.take
  end
end
