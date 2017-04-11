require 'rails_helper'

RSpec.describe Ad, type: :model do
  
  describe 'validations' do
  	
  	let(:user) { FactoryGirl.create(:user) }

  	it 'requires title' do
  		ad = Ad.new(title:'')
  		expect(ad.valid?).to be_falsy
  	end

  	it 'requiures description' do
  		ad = Ad.new(title: 'Title', description: '', user: user, validity: Faker::Time.forward(23, :morning))
  		expect(ad.valid?).to be_falsy
  	end

  	it 'require validity' do
  		ad = Ad.new(title: 'Title', description: 'desc', validity:'')
  		expect(ad.valid?).to be_falsy
  	end

  end

  describe 'association' do

  	it 'belongs_to user' do
  		user = FactoryGirl.create(:user)
  		ad = Ad.new(title: 'Title', description: 'Desc', user: user, validity: Faker::Time.forward(23, :morning))
  	
  		expect(ad.user).to eq(user)
  	end

    it 'has_many job' do
      j = Ad.reflect_on_association(:jobs)
      expect(j.macro).to eq(:has_many)
    end

  end

end
