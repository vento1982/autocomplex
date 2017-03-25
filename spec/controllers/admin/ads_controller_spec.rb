require 'rails_helper'

RSpec.describe Admin::AdsController, type: :controller do 

	describe 'GET index' do

		context 'guest user' do
			it 'redirected to login page' do
				get :index
				expect(response).to redirect_to new_user_session_path
			end

			it 'assigns flash message' do
				get :index
				expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.') 
			end
		end

		context 'authenticate user' do

			let(:user) { FactoryGirl.create(:user) }
			

			before do
				sign_in(user)
			end

			it 'response succesful with an HTTP 200 status code' do
				get :index
				expect(response).to be_success
				expect(response).to have_http_status(200)
			end

			it 'renders :index template' do
				get :index
				expect(response).to render_template(:index)
			end

			it 'assines @ads' do
				ad1 = FactoryGirl.create(:ad, title: 'title1')
				ad2 = FactoryGirl.create(:ad, title: 'title2')

				get :index
				expect(assigns(:ads)).to match_array([ad1, ad2])
			end

		end
	end 

	describe 'GET new' do

		context 'guest user' do
			
			it 'redirected to login page' do
				get :new
				expect(response).to redirect_to new_user_session_path
			end

			it 'assigns flash message' do
				get :new
				expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
			end

		end

		context 'authenticate user' do

			let(:user) { FactoryGirl.create(:user) }

			before do
				sign_in(user)
			end

			it 'renders :new template' do
				get :new
				expect(response).to render_template(:new)
			end

			it 'assignes @ad' do
				get :new
				expect(assigns(:ad)).to be_a_new(Ad)
			end
		end

	end

	describe 'GET show' do

		context 'guest user' do

			let(:ad){ FactoryGirl.create(:ad) }

			it 'redirected to login page' do
				get :show, id: ad.id
				expect(response).to redirect_to new_user_session_path
			end

			it 'assigns flash message' do
				get :show, id: ad.id
				expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
			end

			it 'not assigns @ad' do
				get :show, id: ad.id
				expect(assigns(:ad)).to eq(nil)
			end

		end

		context 'authenticate user' do

			let(:ad){ FactoryGirl.create(:ad) }
			let(:user){ FactoryGirl.create(:user) }

			before do
				sign_in(user)
			end

			it 'renders :show template' do
				get :show, id: ad.id
				expect(response).to render_template(:show)
			end

			it 'assigns @ad' do
				get :show, id: ad.id
				expect(assigns(:ad)).to eq(ad)
			end
			
		end
	end
	
	describe 'get edit' do

		context 'guest user' do
			let(:ad) { FactoryGirl.create(:ad) }

			it 'redirects to login page' do
				get :edit, id: ad.id
				expect(response).to redirect_to new_user_session_path
			end 
		end

		context 'authenticate user' do
			
			let(:ad){ FactoryGirl.create(:ad) }
			let(:user) { FactoryGirl.create(:user) }

			before do
				sign_in(user)
			end

			it 'renders :edit template' do
				get :edit, id: ad.id
				expect(response).to render_template(:edit)
			end

			it 'assigns the requested ad to template' do
				get :edit, id: ad.id
				expect(assigns(:ad)).to eq(ad)
			end
		end

	end

	describe 'PUT update' do

		let(:ad) { FactoryGirl.create(:ad) }
		let(:user) { FactoryGirl.create(:user) }

			before do
				sign_in(user)
			end

		context 'valid date' do
			let(:valid_data) { FactoryGirl.attributes_for(:ad, title: 'New Title')}
			
			it 'redirect to ad#show' do
				put :update, id: ad.id, ad: valid_data
				expect(response).to redirect_to(admin_ad_path(ad)) 
			end

			it 'update ad in the database' do
				put :update, id: ad.id, ad: valid_data
				ad.reload
				expect(ad.title).to eq('New Title')
			end

		end

		context 'invalid data' do
			let(:invalid_data) { FactoryGirl.attributes_for(:ad, title: '', description: 'new desc')}
	
			it 'render edit template' do
				put :update, id: ad.id, ad: invalid_data
				expect(response).to render_template(:edit)
			end

			it "dosen't update ad in the database" do
				put :update, id: ad.id, ad: invalid_data
				ad.reload
				expect(ad.description).not_to eq('new desc')
			end
		end

	end

	describe 'POST create' do

		let(:user) { FactoryGirl.create(:user) }

		before do
			sign_in(user)
		end

		context 'valid date' do
			
			let(:valid_data) { FactoryGirl.attributes_for(:ad) }


			it 'redirect to ads page' do
				post :create, ad: valid_data
				expect(response).to redirect_to(admin_ads_path)
			end

			it 'creates a new ad in database' do
				expect{
					post :create, ad: valid_data
				}.to change(Ad, :count).by(1)				
			end
		end

		context 'invalid data' do

			let(:invalid_data) { FactoryGirl.attributes_for(:ad, title: '')}

			it 'renders :new template' do
				post :create, ad: invalid_data
				expect(response).to render_template(:new)
			end

			it "dosen't create ad in database" do
				expect{
					post :create, ad: invalid_data
				}.not_to change(Ad, :count)
			end
		end
	end

	describe 'DELETE destroy' do

		context 'guest user' do
			let(:ad) { FactoryGirl.create(:ad) }

			it 'redirect to login page' do
				delete :destroy, id: ad.id
				expect(response).to redirect_to new_user_session_path
			end
		end

		context 'authenticate user' do

			let(:user) { FactoryGirl.create(:user) }
			let(:ad) { FactoryGirl.create(:ad) }

			before do
				sign_in(user)
			end

			it 'redirects to ads page' do
				delete :destroy, id: ad.id
				expect(response).to redirect_to(admin_ads_path)
			end

			it 'deletes ad from the database' do
				delete :destroy, id: ad.id
				expect(Ad.exists?(ad.id)).to be_falsy
			end

		end

	end
	
end