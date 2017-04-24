FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "emailewddddsssssssddrrrrdddde#{n}@e-mail.com" }
    password "secretsecret" 
  end
end
