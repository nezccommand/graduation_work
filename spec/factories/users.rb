FactoryBot.define do
  factory :user do
    name { 'User' }
    email { "test@example.com" }
    confirmed_at { Time.current }
    password { "password" }
    password_confirmation { "password" }
    provider { nil }
    uid { nil }

    trait :google_user do
      name { 'Google User' }
      provider { 'google_oauth2' }
      uid { '12345' }
      password { nil }
      password_confirmation { nil }
    end
  end
end
