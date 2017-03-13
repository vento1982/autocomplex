require 'rails_helper'
require_relative '../support/admin_page'

feature 'sort products' do
	
	let(:admin_page) { AdminPage.new}
	
	

	let(:user) { FactoryGirl.create(:user)}

	background do
		admin_page.visit_page.login_as(user)
		expect(page).to have_content('Logout')
		visit admin_products_path
		
	end

	scenario 'by name' do
		FactoryGirl.create(:product, title: 'Product Y')
		FactoryGirl.create(:product, title: 'Product X')
		
		click_link "Title"
		
		products_name = page.all('td.product-name').map(&:text)
		expect(products_name).to eq(['Product X', 'Product Y'])
	end

	scenario 'by description' do
		FactoryGirl.create(:product, title: 'Extra', description: 'Content 12')
		FactoryGirl.create(:product, title: 'Extra 2', description: 'Content 10')

		click_link 'Description'

		products_description = page.all('td.product-desc').map(&:text)
		expect(products_description).to eq(['Content 10', 'Content 12'])
	end

	scenario 'by data' do
		product_1 = FactoryGirl.create(:product, title:'Mistrz1')
		product_2 = FactoryGirl.create(:product, title: 'Mistrz2')

		click_link 'Created at'

		products_data = page.all('td.product-data').map(&:text)
		expect(products_data).to eq([product_1.created_at, product_2.created_at])
	end

end