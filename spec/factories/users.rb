FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "mail#{n}@email.com" }
    password "secretsecret" 
  end
end
