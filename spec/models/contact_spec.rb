require 'rails_helper'

RSpec.describe Contact, type: :model do
	describe 'validations' do
		it 'requires name' do
			contact = Contact.new(name: '')
			expect(contact.valid?).to be_falsy
		end
		it 'requires email' do
			contact = Contact.new(email: '')
			expect(contact.valid?).to be_falsy
		end
	end
end