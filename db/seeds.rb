10.times do
	Product.create(title: Faker::Hacker.noun, description: Faker::Hacker.say_something_smart)
end