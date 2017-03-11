require 'rails_helper'
require_relative '../support/admin_page'
require_relative '../support/picture_form'

feature 'add new picture' do

	let(:admin_page) { AdminPage.new }
	let(:user) { FactoryGirl.create(:user) }
	let(:picture_form) { PictureForm.new }

	background do
		admin_page.visit_page.login_as(user)
	end

	scenario 'add new picture with a valid data' do
		picture_form.visit_page.add_picture(name: "Picture").submit

		expect(page).to have_content('Picture has been created')
		expect(page).to have_css('#picture-quantity', text: '1')
	end
end