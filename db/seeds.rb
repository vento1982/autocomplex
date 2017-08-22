#print "Product "
#10.times do
#	Product.create(title: Faker::Hacker.noun, 
#		description: Faker::Hacker.say_something_smart,
#		long_description: Faker::Lorem.paragraphs(3).join("\n\n"))
#	print "."
#end

#user = FactoryGirl.create(:user)

#print "Pictures "

#(1..40).each do |x|
#	Picture.create!(name:"Image#{x}", image: Faker::Avatar.image('Img',"300x300","jpg","set#{[1,2,3].sample}","bg#{[1,2].sample}"), user: user )
#	print"."
#end
#puts "End"

#print 'Start adding Ads'

#(1..40).each do |ad|
#	Ad.create!(title: Faker::Hacker.noun, description: Faker::Hacker.say_something_smart, validity: Faker::Time.forward(23,:morning))
#	print'.'
#end

#print 'All ads has beeen added!!!'


print 'Start adding Pelope aplication'

(1..40).each do |job|
	Job.create(name: Faker::Name.name, email: Faker::Internet.email, message: Faker::Hacker.say_something_smart , ad: Ad.order("RANDOM()").first)
	print '.'
end

print 'End'

