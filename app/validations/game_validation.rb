GameValidation = Dry::Validation.Schema do
  AVAILABLE_SCORE = %w[301 501]
  AVAILABLE_STATUSES = %w[active finished]

  required(:score).filled(:str?, included_in?: AVAILABLE_SCORE)
  required(:status).filled(:str?, included_in?: AVAILABLE_STATUSES)
end