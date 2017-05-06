require 'rails_helper'
require_relative '../support/admin_page'

feature 'admin uncomplete the job' do 

	let(:user) { FactoryGirl.create(:user) }
	let(:admin_page) { AdminPage.new }

	background do
		FactoryGirl.create(:job, completed_at: Time.now)

		admin_page.visit_page.login_as(user)
		expect(page).to have_content 'Logout'
		
		visit admin_jobs_path
	end

	it 'can click on uncomplete button' do
		find_link(class: 'admin-jobs-btn__btn-uncomplete').click

		expect(page).to have_content 'Job has been uncompleted.'
	end

	it 'only when sign in' do
		admin_page.logout
		visit admin_jobs_path

		expect(page).to have_content 'You need to sign in or sign up before continuing.'
	end
end