require 'rails_helper'

RSpec.describe JobsController, type: :controller do
	
	describe 'POST :create' 

		context 'valid data' do
			
			it 'redirect to ads_path' do
				ad = FactoryGirl.create(:ad) 
				valid_data = FactoryGirl.attributes_for(:job, ad_id: ad.id)
			
				post :create, ad_id: ad.id, job: valid_data
				expect(response).to redirect_to ads_path
			end

			it 'assigns flash message' do
				ad = FactoryGirl.create(:ad) 
				valid_data = FactoryGirl.attributes_for(:job, ad_id: ad.id)

				post :create, ad_id: ad.id, job: valid_data
				expect(flash[:notice]).to eq('Thank you for your apply.')

			end

		end

		context 'invalid data' do
			
			it 'renders :new template' do

				ad = FactoryGirl.create(:ad) 
				invalid_data = FactoryGirl.attributes_for(:job, email: "", ad_id: ad.id)

				post :create,ad_id: ad.id, job: invalid_data
				expect(response).to render_template('ads/show')
			end
			
			it 'assigns flash message' do
				ad = FactoryGirl.create(:ad) 
				invalid_data = FactoryGirl.attributes_for(:job, email: "", ad_id: ad.id)

				post :create,ad_id: ad.id, job: invalid_data
				expect(flash[:error]).to eq('Cannot send message.')
			end

		end

end
