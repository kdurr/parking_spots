# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parking_registration do
    first_name "Bern"
    last_name "Durr"
    email "berndurr@gmail.com"
    spot_number 8
    day_of { Date.today }
  end
end
