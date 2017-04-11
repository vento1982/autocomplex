require 'rails_helper'

feature 'user visits ad#show' do 
	let(:ad) { FactoryGirl.create(:ad, title: 'New title')}

	background do
		
	end

	it 'should see ad page' do
		visit ad_path(ad)
		expect(page).to have_content('New title')
	end

	it 'should see back link' do
		visit ad_path(ad)
		
		within('.carrer-nav_container') do
			expect(page).to have_content('All ads')
		end
	end
end