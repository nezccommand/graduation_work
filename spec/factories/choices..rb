FactoryBot.define do
  factory :choice do
    content { "選択肢A" }
    is_correct { false }
    quiz
  end
end