require 'rails_helper'
require_relative '../support/admin_page'

feature 'admin visits ads page' do
	
	let(:admin_page){ AdminPage.new }
	let(:user) { FactoryGirl.create(:user) }
	
	background do
		admin_page.visit_page.login_as(user)
		expect(page).to have_content('Logout')
	end

	scenario 'should see ads page' do
		FactoryGirl.create(:ad, title: 'Super cool Ad!')
		visit admin_ads_path
		expect(page).to have_content('Super cool Ad!')
	end

	scenario 'when only siged in' do

	end
end