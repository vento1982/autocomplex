require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
	
	describe 'GET :new action' do
		it 'assigns new messages to @contact' do
			get :new
			expect(assigns(:contact)).to be_a_new(Contact)
		end
	end

end