FactoryBot.define do
  factory :domain_name_system do
    ip { Faker::Internet.ip_v4_address }
    hostnames { FactoryBot.create_list(:hostname, 3) } 
  end
end