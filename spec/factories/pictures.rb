FactoryGirl.define do
  factory :picture do
    name "Extra Name"
   	image { File.new("#{Rails.root}/spec/files/images/test.jpg") }
    user
  end
end
