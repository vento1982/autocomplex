require 'rails_helper'

RSpec.describe Picture, type: :model do
	
	describe 'validations' do

		it 'requires name' do
			picture = Picture.new(name: "")
			expect(picture.valid?).to be_falsy
		end

		it 'requires a image file' do
			picture = Picture.new(name: 'New name', image: nil)
			expect(picture.valid?).to be_falsy
		end

	end

	describe 'associations' do

		it 'belongs to user' do
			picture = Picture.new(name: "New Name", user: nil)
			expect(picture.valid?).to be_falsy
		end

		it 'has belongs_to user association' do
			# 1 approach /integrations/

			user = FactoryGirl.create(:user)
			picture = Picture.new(name: "New Name", user: user)
			expect(picture.user).to eq(user)

			# 2 approach

			u = Picture.reflect_on_association(:user)
			expect(u.macro).to eq(:belongs_to)
		end

	end


end
