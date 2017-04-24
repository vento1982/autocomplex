require 'rails_helper'
require_relative '../support/admin_page'


feature 'admin completed job' do
	
	let(:admin_page) { AdminPage.new }
	let(:user) { FactoryGirl.create(:user) }
	

	background do
		FactoryGirl.create(:job)

		admin_page.visit_page.login_as(user)
		expect(page).to have_content 'Logout'
		
		visit admin_jobs_path
	end

	it 'can click on completed button' do
		click_on 'Completed'
		expect(page).to have_content 'Job has been completed.'
	end

	it 'only wehen sign in' do
		admin_page.logout
		visit admin_jobs_path

		expect(page).to have_content 'You need to sign in or sign up before continuing.'
	end

end
