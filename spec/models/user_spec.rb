require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do
  
  	it 'has_many pictures' do
  		pictures = User.reflect_on_association(:pictures)

  		expect(pictures.macro).to eq(:has_many)
  	end

  	it 'has_many products' do
  		products = User.reflect_on_association(:products)

  		expect(products.macro).to eq(:has_many)
  	end
    
    it 'has_many ads' do
      ads = User.reflect_on_association(:ads)

      expect(ads.macro).to eq(:has_many)
    end
  end

end
