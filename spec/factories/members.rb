# spec/factories/members.rb
FactoryBot.define do
  factory :member do
    first_name { "John" }
    last_name  { "Doe" }
    city       { "New York" }
    state      { "NY" }
    country    { "USA" }
    association :team  # assuming a member belongs to a team
  end
end
