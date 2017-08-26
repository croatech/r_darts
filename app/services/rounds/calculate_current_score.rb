class Rounds::CalculateCurrentScore
  include Interactor

  def call
    round = context.round
    game ||= round.game
    last_score = context.last_score || 0
    resulted_score = game.score - (game.rounds.where(user_id: round.user_id).pluck(:score).reduce(:+) + last_score)
    context.score = resulted_score
  end
end
