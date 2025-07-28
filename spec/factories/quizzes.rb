FactoryBot.define do
  factory :quiz do
    question { "この中で正しいのはどれ？" }
    genre { "基本知識" }
    difficulty { "easy" }

    after(:create) do |quiz|
      create_list(:choice, 3, quiz: quiz)
      create(:choice, quiz: quiz, is_correct: true)
    end
  end
end