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

	scenario 'with a valid data' do
		picture_form.visit_page.add_picture(name: "Picture", image: 'test.jpg').submit

		expect(Picture.last.image_file_name).to eq('test.jpg')
		expect(page).to have_content('Picture has been created')	
		expect(page).to have_css('#picture-quantity', text: '1')
	end

	scenario 'with invalid file content' do
		picture_form.visit_page.add_picture(image: 'test.pdf').submit
		expect(page).to have_content('has contents that are not what they are reported to be')
	end

	scenario 'with invalid file extention' do
		picture_form.visit_page.add_picture(image: 'test1.pdf').submit
		expect(page).to have_content('Imageis invalid')
	end

end