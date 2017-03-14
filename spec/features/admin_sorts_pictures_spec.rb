require 'rails_helper'
require_relative '../support/admin_page'

feature 'sort products' do

	let(:user) { FactoryGirl.create(:user) }
	let(:admin_page) { AdminPage.new }
	
	background do
		admin_page.visit_page.login_as(user)
		expect(page).to have_content('Logout')
		
		visit admin_pictures_path

	end
	
	scenario 'by name' do
		FactoryGirl.create(:picture, name: 'Picture B')
		FactoryGirl.create(:picture, name: 'Picture A')

		click_link 'Title'
		pictures = page.all('td.picture-title').map(&:text)
		
		expect(pictures).to eq(['Picture A', 'Picture B'])
	end

	scenario 'by data created' do
		picture_1 = FactoryGirl.create(:picture)
		picture_2 = FactoryGirl.create(:picture)

		click_link 'Created at'
		pictures = page.all('td.picture-date').map(&:text)
		
		expect(pictures).to eq([picture_1.created_at.to_s, picture_2.created_at.to_s])
	end
end