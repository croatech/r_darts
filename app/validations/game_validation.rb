GameValidation = Dry::Validation.Schema do
  AVAILABLE_SCORE = %w[301 501]

  required(:score).filled(included_in?: AVAILABLE_SCORE)
end