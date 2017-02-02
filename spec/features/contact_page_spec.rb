require 'rails_helper'

feature 'contact page' do
	scenario 'contact message' do
		visit('/contacts')
		expect(page).to have_content('Kontakt')
	end

end