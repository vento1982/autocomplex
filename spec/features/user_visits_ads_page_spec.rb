require 'rails_helper'

feature 'user visits ads page' do
	
	let(:user) { FactoryGirl.create(:user) }

	scenario 'should see ads page' do
		FactoryGirl.create(:ad,title: 'Ad on ads page', description: 'mis', validity: '2017-03-20 18:56:15')
		visit '/ads'
		
		expect(page).to have_content('Ad on ads page')
	end

end