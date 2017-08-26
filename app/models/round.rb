class Round < ApplicationRecord
  belongs_to :user
  belongs_to :game

  enum status: %i[active finished]

  def current_user_score
    Rounds::CalculateCurrentScore.call(round: self).score
  end
end
