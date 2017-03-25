require 'rails_helper'
require_relative '../support/admin_page'
require_relative '../support/ad_form'

feature  'create new ad' do

	let(:admin_page) { AdminPage.new }
	let(:ad_form) { AdForm.new }
	let(:user) { FactoryGirl.create(:user) }

	background do
		admin_page.visit_page.login_as(user)
	end

	scenario 'with invalid title data' do
		ad_form.visit_page.add_ad(title: '').submit
		expect(page).to have_content("can't be blank")
	end

	scenario 'with valid title data' do
		ad_form.visit_page.add_ad(title: 'SUper title').submit
		expect(page).to have_content('Ad has been created.')
	end

end