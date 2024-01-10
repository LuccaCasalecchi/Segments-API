# spec/factories/segments.rb
FactoryBot.define do
  factory :segment do
    sequence(:name) { |n| "Segment #{n}" }
    description { "Description of Segment" }
  end
end
