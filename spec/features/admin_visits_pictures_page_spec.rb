require 'rails_helper'
require_relative '../support/admin_page'

feature 'add_photo_to_gallery' do
	let(:user) {FactoryGirl.create(:user)}
	let(:admin_page){AdminPage.new}

	background do
		admin_page.visit_page.login_as(user)
		expect(page).to have_content('Logout')
		visit admin_pictures_path
	end

	scenario 'should see pictures list' do

	end

	scenario 'only when sign in' do
	end
end