require 'rails_helper'
require_relative '../support/contact_form'

feature 'contact form' do

	let(:contact_form) { ContactForm.new }

	scenario 'visit contact form page' do
		contact_form.visit_page

		expect(page).to have_content('Kontakt')
	end

	scenario 'delivers with a valid message' do
		contact_form.visit_page.add_msg(name: 'First Name', email: 'mail@mail.pl', message: "New Msg").submit

		expect(page).to have_content('Thank you for your message. We will contact you soon!')
	end

	scenario 'does not deliver a mesage with a missing name' do
		contact_form.visit_page.add_msg(name: "").submit

		expect(page).to have_content('Cannot send message.')

	end

	scenario 'does not deliver a message with missing email' do
		contact_form.visit_page.add_msg(email: "").submit

		expect(page).to have_content('Cannot send message.')
	end

	scenario 'does not deliver a message with missing message' do
		contact_form.visit_page.add_msg(message: "").submit

		expect(page).to have_content('Cannot send message.')
	end
end