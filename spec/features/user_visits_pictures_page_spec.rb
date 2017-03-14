require 'rails_helper'

feature 'user visits pictures page' do
	
	FactoryGirl.create(:picture, name: 'Super cool picture in this gallery')

	scenario 'should see pictures page' do
		visit '/'
		click_link 'Gallery'

		expect(page).to have_content('Super cool picture in this gallery')
	end
end