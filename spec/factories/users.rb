FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@e-mail.com" }
    password "secretsecret" 
  end
end
