# spec/factories/tags.rb
FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "Tag #{n}" }
  end
end
