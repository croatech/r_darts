ScoreValidation = Dry::Validation.Schema do
  required(:score).value(:int?, lteq?: 180)
end
