require 'rails_helper'
require_relative '../support/admin_page'

feature 'admin destroy job' do
	
	let(:admin_page) { AdminPage.new }
	let(:user) { FactoryGirl.create(:user) }
	
	background do
		FactoryGirl.create(:job)

		admin_page.visit_page.login_as(user)
		expect(page).to have_content 'Logout'
		
		visit admin_jobs_path
	end

	it 'can click on delete button' do
		click_on 'Delete'
		expect(page).to have_content 'Job has been delete.'
	end

	it 'only when signed in' do
		admin_page.logout
		visit admin_jobs_path

		expect(page).to have_content 'You need to sign in or sign up before continuing.'
	end
	
end