require 'rails_helper'

RSpec.describe StaticController, type: :controller do
	
	describe 'GET #about' do
		it 'responds successfully with HTTP 200 status code' do
			get :about
			expect(response).to be_success
			expect(response).to have_http_status(200)
		end

		it 'renders the about template' do 
			get :about
			expect(response).to render_template(:about) 
		end
    end

end
