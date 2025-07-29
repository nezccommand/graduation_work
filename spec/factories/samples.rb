FactoryBot.define do
  factory :sample do
    sequence(:title) { |n| "サンプルタイトル#{n}" }
    sequence(:short_description) { |n| "これはサンプルの短い説明文#{n}です。" }
    description { "詳細な説明文です。" }
    sample_text { "メールの本文などのサンプルテキストです。" }

    after(:create) do |sample|
      sample.tags << create(:tag)
    end
  end
end
