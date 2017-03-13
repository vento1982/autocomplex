require 'rails_helper'
require_relative '../support/admin_page'
require_relative '../support/admin_picture_page'

feature 'picture page' do 

	let(:admin_page) { AdminPage.new }
	let(:user) { FactoryGirl.create(:user) }

	background do
		admin_page.visit_page.login_as(user)
	end

	scenario 'picture admin page' do
		picture = FactoryGirl.create(:picture, name: 'Just did it!')
		visit("admin/pictures/#{picture.id}")

		expect(page).to have_content('Just did it!') 
	end
	
end