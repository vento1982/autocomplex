require 'rails_helper'
require_relative '../support/admin_page'
require_relative '../support/product_form'

feature 'create new product' do
	
	let(:admin_page) { AdminPage.new }
	let(:product_form) { ProductForm.new }
	let(:user) { FactoryGirl.create(:user) }

	background do
		admin_page.visit_page.login_as(user)
	end

	scenario 'with valid data' do
		product_form.visit_page.add_product(title: "Tire", description: "Super cool spare tire!").submit

		expect(page).to have_content("Product has been created")
		expect(Product.last.title).to eq('Tire')
	end

	scenario 'can not create new product with invalid data' do
		product_form.visit_page.add_product(title: "", description: "").submit

		expect(page).to have_content("can't be blank")
	end
end