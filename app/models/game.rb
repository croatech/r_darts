class Game < ApplicationRecord
  validates :score, :status, presence: true
  validates :status, uniqueness: true

  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'

  enum status: %i[active finished]
end
