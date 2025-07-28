FactoryBot.define do
  factory :badge do
    sequence(:name) { |n| "バッジ#{n}" }
    difficulty { "easy" }
    genre { "基本知識" } 
    description { "簡単バッジ" }
  end

  trait :hard対応方法 do
    difficulty { "hard" }
    genre { "対応方法" }
    name { "難しいバッジ" }
  end
end