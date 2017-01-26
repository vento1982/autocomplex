print "Product "
10.times do
	Product.create(title: Faker::Hacker.noun, 
		description: Faker::Hacker.say_something_smart,
		long_description: Faker::Lorem.paragraphs(3).join("\n\n"))
	print "."
end