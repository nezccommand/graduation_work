# spec/factories/quiz_histories.rb
FactoryBot.define do
  factory :quiz_history do
    correct_count { 5 }
    total_count { 10 }
    difficulty { "easy" }
    genre { "基本知識" }
    association :user
    created_at { 1.day.ago }
    updated_at { Time.current }
  end
end
