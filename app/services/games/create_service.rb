class Games::CreateService
  include Dry::Transaction

  step :init
  step :validate
  step :persist

  def init(input)
    @params = input[:params]
    @object = Game.new(params)

    Right(nil)
  end

  def validate(_input)
    validation = GameValidation.call(params)
    if validation.success?
      Right(nil)
    else
      Left(validation.errors)
    end
  end

  def persist(_input)
    ActiveRecord::Base.transaction do
      object.save
      object.game_users.create(user: User.first)
      object.game_users.create(user: User.second)
      create_first_round
    end

    Right(object)
  end

  private

  attr_reader :params, :object

  def create_first_round
    user_id = object.users.ids.sample
    object.rounds.create(user_id: user_id)
  end
end