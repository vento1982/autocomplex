require 'rails_helper'

feature 'authenticate user can create new product' do
	scenario 'create new product with valid data' do
		visit('/admin/')
		click_on('Nowa usługa')

		fill_in('Title', with: 'Ogumienie')
		fill_in('Description', with: 'Super guma')
		click_on('Dodaj usługę')

		expect(page).to have_content('Usługa została dodana')
		expect(Product.last.title).to eq('Ogumienie')
	end
end