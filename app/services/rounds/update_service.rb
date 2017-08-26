class Rounds::UpdateService
  include Dry::Transaction

  step :init
  step :validate
  step :error_if_score_less_than_zero
  step :close_a_game_if_score_equal_zero
  step :update

  def init(input)
    @params = input[:params]
    @object = Round.find(params[:id])
    params[:score] = params[:score].to_i
    @errors = []
    @current_user_score ||= Rounds::CalculateCurrentScore.call(round: object, last_score: params[:score]).score

    Right(nil)
  end

  def validate(_input)
    validation = ScoreValidation.call(params)
    if validation.success?
      object.score = params[:score]
      Right(nil)
    else
      Left(validation.errors)
    end
  end

  def error_if_score_less_than_zero(_input)
    if current_user_score < 0
      errors << 'Current score must be equal or greater then Game score'
      Left(errors)
    else
      Right(nil)
    end
  end

  def close_a_game_if_score_equal_zero(_input)
    finish_game if game_over?

    Right(nil)
  end

  def update(_input)
    ActiveRecord::Base.transaction do
      object.status = 'finished'
      object.save
      create_next_round unless game_over?
    end

    Right(object)
  end

  private

  attr_reader :params, :object, :errors, :current_user_score

  def create_first_round
    user_id = object.users.ids.sample
    object.rounds.create(user_id: user_id)
  end

  def finish_game
    object.game.update(winner_id: object.user_id, status: 'finished')
  end

  def game_over?
    current_user_score == 0
  end

  def create_next_round
    another_user = object.game.users.where.not(id: object.user_id).take
    Round.create(game_id: object.game_id, user_id: another_user.id)
  end
end