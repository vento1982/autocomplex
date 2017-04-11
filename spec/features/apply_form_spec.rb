require 'rails_helper'
#require_relative '..support/apply_form'

feature 'apply form' do
	
	let(:ad) { FactoryGirl.create(:ad) }

	scenario 'visits apply form page' do
		visit ad_path(ad)
		expect(page).to have_content('Apply now')
	end

	scenario 'delivers with a valid message' do
		visit ad_path(ad)
		fill_in 'Name', with: 'Martin'
		fill_in 'Email', with: 'martin@email.pl'
		fill_in 'Message', with: 'Test msg.'
		click_on 'Apply now'

		expect(page).to have_content('Thank you for your apply.')
	end

	scenario 'does not deliver message with a missing email' do
		visit ad_path(ad)
		fill_in 'Name', with: 'Martin'
		fill_in 'Email', with: ''
		fill_in 'Message', with: 'Test msg'
		click_on  'Apply now'

		expect(page).to have_content("can't be blank")
	end

	scenario 'does not deliver message wit a missing name' do
		visit ad_path(ad)
		fill_in 'Name', with: ''
		fill_in 'Email', with: 'email@email.pl'
		fill_in 'Message', with: 'New msg'
		click_on 'Apply now'

		expect(page).to have_content("can't be blank")
	end

	scenario 'does not deliver message with a missing message' do
		visit ad_path(ad)
		fill_in 'Name', with: 'Martin'
		fill_in 'Email', with: 'martin@email.pl'
		fill_in 'Message', with: ''
		click_on 'Apply now'

		expect(page).to have_content("can't be blank")
	end
end