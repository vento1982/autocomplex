require 'rails_helper'

RSpec.describe Job, type: :model do
  
  describe 'validations' do

  	it 'requires name' do
  		job = Job.new(name: '', email: "biuro@wp.pl", message: "Test msg")
  		expect(job.valid?).to be_falsy
  	end

  	it 'requires email' do
  		job = Job.new(name: 'New name', email: '', message: 'Test msg')
  		expect(job.valid?).to be_falsy
  	end

  	it 'requires message' do
  		job = Job.new(name: 'Martin', email: 'test@email.com', message: '')
  		expect(job.valid?).to be_falsy
  	end

  end

  describe 'assotiations' do
  	
  	it 'belongs to ad' do
  		job = Job.new(name: 'martin', email: 'test@email.com', message: 'test msg', ad_id: nil)
  		expect(job.valid?).to be_falsy
  	end

  	it 'has belongs_to ad' do
  		#1
  		ad = FactoryGirl.create(:ad)
  		job = Job.new(name: 'Martin', email: 'test@emailcom', message: 'test msg', ad: ad)
  		expect(job.ad).to eq(ad)

  		#2
  		a = Job.reflect_on_association(:ad)
  		expect(a.macro).to eq(:belongs_to)

  	end

  end

  describe '#completed?' do
    
    it 'returns false if is empty' do  
      job = FactoryGirl.create(:job)
      expect(job.completed?).to be_falsy
    end

  end

end
