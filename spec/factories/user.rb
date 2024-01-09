FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    sequence(:email) { |n| "user#{n}@example.com" }
    birth_date { "2000-01-01" }
    admission_date { "2022-01-01" }
    is_active { true }
    sex { "M" }
    last_sign_in_at { Time.current }
  end
end
