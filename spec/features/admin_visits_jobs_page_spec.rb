require 'rails_helper'
require_relative '../support/admin_page'

feature 'admin visits jobs_path' do
	
	let(:admin_page) { AdminPage.new }
	let(:user) { FactoryGirl.create(:user) }

	background do
		admin_page.visit_page.login_as(user)
		expect(page).to have_content 'Logout'
		visit admin_jobs_path
	end

	scenario 'should see jobs list' do
		FactoryGirl.create(:job, name: 'New job')
		click_on 'Jobs'

		expect(page).to have_content 'New job'
	end

	scenario 'only when sign in' do
		admin_page.logout
		visit admin_jobs_path
		
		expect(page).to have_content 'You need to sign in or sign up before continuing.'
	end

end