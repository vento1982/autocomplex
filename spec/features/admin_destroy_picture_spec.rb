require 'rails_helper'
require_relative '../support/admin_page'

feature 'destroy ad' do
	
	let(:user){ FactoryGirl.create(:user) }
	let(:admin_page) { AdminPage.new }

	background do
		admin_page.visit_page.login_as(user)
	end

	scenario 'admin can destroy ad' do
		picture = FactoryGirl.create(:picture)
		visit ("/admin/pictures/#{picture.id}")
		click_link('Delete')

		expect(page).to have_content('Picture has been deleted.')
	end

end