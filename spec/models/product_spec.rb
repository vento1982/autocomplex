require 'rails_helper'

RSpec.describe Product, type: :model do
	describe 'validations' do 
		it 'requires title' do	
			product = Product.new(title: '')
			expect(product.valid?).to be_falsy
		end
		it 'requires description' do
			product = Product.new(description: '')
			expect(product.valid?).to be_falsy
		end	
		it 'requires title to by unique for one user' do
			user = FactoryGirl.create(:user)
			first_product = FactoryGirl.create(:product, title: 'First product', user: user)
			new_product = Product.new(title: 'First product', user: user)
			expect(new_product.valid?).to be_falsy
		end
	end
end
