require 'rails_helper'

feature 'about page' do
	scenario 'about message' do
		visit('/o-nas')
		expect(page).to have_content('O firmie')		
	end
end