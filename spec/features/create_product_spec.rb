require 'rails_helper'
require_relative '../support/admin_page'
require_relative '../support/product_form'

feature 'create new product' do
	
	let(:admin_page) { AdminPage.new }


	scenario 'create new product with valid data' do
		
		admin_page.visit_page.new_product
		product_form.add_product(title: "Tire", description: "Super cool spare tire!").submit

		expect(page).to have_content("Product has been created")
		expect(Product.last.title).to eq('Tire')
	end
end