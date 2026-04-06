FactoryBot.define do
  factory :user do
    provider { "github" }
    sequence(:provider_uid) { |n| "uid_#{10_000 + n}" }
    sequence(:username) { |n| "user#{n}" }
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    avatar_url { "https://avatars.githubusercontent.com/u/1" }
    access_token { "test_access_token" }
    deleted_at { nil }
    username_changed_at { nil }
  end
end
