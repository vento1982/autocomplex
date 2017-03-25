require 'rails_helper'
require_relative '../support/admin_page'


feature 'ad page' do

	let(:user) { FactoryGirl.create(:user) }
	let(:admin_page) { AdminPage.new }

	background do
		admin_page.visit_page.login_as(user)
	end

	scenario 'admin can edit ad' do
		ad = FactoryGirl.create(:ad)
		visit edit_admin_ad_path(ad)
		fill_in('Title', with: 'You have edited ad!')
		click_button('Update ad')
	end
end