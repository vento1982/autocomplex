require 'rails_helper'
require_relative '../support/admin_page'

feature 'admin visits ad#show' do

let(:user) { FactoryGirl.create(:user) }
let(:admin_page) { AdminPage.new }

background  do
	admin_page.visit_page.login_as(user)
end

scenario 'should see ad page' do
	ad = FactoryGirl.create(:ad, title: 'You are here! Avesome!')
	visit ("admin/ads/#{ad.id}")

	expect(page).to have_content('You are here! Avesome!')
end


end