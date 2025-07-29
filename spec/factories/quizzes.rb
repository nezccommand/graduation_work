FactoryBot.define do
  factory :quiz do
    sequence(:question) { |n| "この中で正しいのはどれ？ No.#{n}" }
    genre { "基本知識" }
    difficulty { "easy" }

    after(:create) do |quiz|
      create_list(:choice, 3, quiz: quiz, is_correct: false)
      create(:choice, quiz: quiz, is_correct: true)
    end
  end
end