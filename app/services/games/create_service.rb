class Games::CreateService
  include Dry::Transaction

  step :init
  step :validate
  step :persist

  def init(input)
    @params = input[:params].merge(status: 'active')
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
    end

    Right(object)
  end

  private

  attr_reader :params, :object
end