require 'rails_helper'
require_relative '../support/admin_page'


feature 'admin visits job#show' do 	
	
	let(:admin_page) { AdminPage.new}
	let(:user) { FactoryGirl.create(:user) }

	background do
		admin_page.visit_page.login_as(user)
		FactoryGirl.create(:job, name: 'New name job')

		visit admin_jobs_path
	end

	scenario 'can click on show button' do
		find_link(class: 'admin-jobs-btn__btn-show').click

		expect(page).to have_content 'New name job'
	end

	scenario 'should see job page' do
		job = FactoryGirl.create(:job, message: 'Test msg.')

		visit admin_job_path(job)
		expect(page).to have_content 'Test msg.'
	end

	scenario 'should see back link' do

	end

end