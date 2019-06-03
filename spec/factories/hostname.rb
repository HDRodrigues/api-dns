FactoryBot.define do
  factory :hostname do
    sequence(:name) { |n| "#{Faker::Internet.domain_name}_#{n}" }
  end
end
