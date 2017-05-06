require 'rails_helper'

RSpec.describe AdsController, type: :controller do

	describe 'GET index' do
		
		it 'respones with an HTTP 200 status code' do
			get :index
			expect(response).to be_success
			expect(response).to have_http_status(200) 
		end

		it 'renders the index template' do
			get :index
			expect(response).to render_template(:index)
		end

		it 'loads all of the ads to the @ads' do
			ad1 = FactoryGirl.create(:ad)
			ad2 = FactoryGirl.create(:ad)

			get :index
			expect(assigns(:ads)).to eq([ad1,ad2])
		end
	end

	describe 'GET show' do

		let(:ad) { FactoryGirl.create(:ad)}

		it 'renders show template' do
			get :show, id: ad
			expect(response).to render_template(:show)
		end

		it 'assigns ad to @ad' do
			get :show, id: ad
			expect(assigns(:ad)).to eq(ad)
		end
		
	end
end
