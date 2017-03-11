require 'rails_helper'

RSpec.describe Admin::PicturesController, type: :controller do

	describe 'GET index' do
		context 'guest user' do
			it 'is redirected to login page' do
				get :index
				expect(response).to redirect_to new_user_session_path
			end
			it 'assigns flash message' do
				get :new
				expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
			end
		end

		context 'authenticate user' do

			let(:user) { FactoryGirl.create(:user) }
			let(:picture) { FactoryGirl.create(:picture) }

			before do 
				sign_in(user)
			end

			it 'renders :index template' do
				get :index
				expect(response).to render_template(:index)
			end

			it 'assigns @pictures' do
				get :index
				expect(assigns(:pictures)).to eq([picture])
			end

		end
	end

	describe 'GET new' do
		context 'guest user' do
			it 'is redirected to login page' do
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
			it ' assigns new pictures to template' do
				get :new
				expect(assigns(:picture)).to be_a_new(Picture)
			end
		end
	end

end
