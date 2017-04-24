require 'rails_helper'
require_relative '../support/admin_page'

feature 'visits pictures page' do

	let(:user) {FactoryGirl.create(:user)}
	let(:admin_page){AdminPage.new}

	background do
		admin_page.visit_page.login_as(user)
		expect(page).to have_content('Logout')
		visit admin_pictures_path
	end

	scenario 'should see pictures list' do
		FactoryGirl.create(:picture, name: 'Super cool picture!')
		visit admin_pictures_path
		expect(page).to have_content('Super cool picture!')
	end

	scenario 'only when sign in' do
		admin_page.logout
		visit admin_pictures_path
		expect(page).to have_content('You need to sign in or sign up before continuing.')
	end
	
end