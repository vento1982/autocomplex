require 'rails_helper'
require_relative '../support/admin_page'

feature 'User visit products page' do
	
	let(:admin_page) {AdminPage.new}
	let(:user) {FactoryGirl.create(:user)}
	

	background do
		admin_page.visit_page.login_as(user)
		expect(page).to have_content 'Logout'
		visit admin_products_path
	end

	scenario 'should see products list' do
		FactoryGirl.create(:product, title: 'Super tires')
		visit admin_products_path
		expect(page).to have_content "Super Tires"
	end

	scenario 'only when sign in' do
		admin_page.logout
		visit admin_products_path
		expect(page).to have_content 'You need to sign in or sign up before continuing.'
	end
end