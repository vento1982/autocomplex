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

	describe 'GET show' do

		context 'guest user' do
			
			let(:picture) { FactoryGirl.create(:picture) }

			it 'is redirected to login page' do
				get :show, id: picture.id

				expect(response).to redirect_to new_user_session_path
			end

			it 'not assigns @picture' do
				get :show, id: picture.id

				expect(assigns(:picture)).to eq(nil)
			end

		end

		context 'authenticate user' do

			let(:picture) { FactoryGirl.create(:picture) }
			let(:user) { FactoryGirl.create(:user) }

			before do
				sign_in(user)
			end

			it 'is renders :show template' do
				get :show, id: picture.id

				expect(response).to render_template(:show)
			end

			it 'assigns @picture' do
				get :show, id: picture.id

				expect(assigns(:picture)).to eq(picture)
			end
		end
	end

	describe 'POST create' do

		context 'valid data' do

			let(:user) { FactoryGirl.create(:user) }
			let(:valid_data) { FactoryGirl.attributes_for(:picture)}

			before do
				sign_in(user)
			end	

			#it 'is redirected to login page' do
			#	post :create, picture: valid_data
			#	expect(response).to redirect_to admin_pictures_path
			#end

			#it 'creates new product in database' do
			#	post :create, picture: valid_data
			#	expect change(Product, :count).by(1)
			#end

		end

	end

	describe 'GET edit' do
		
		let(:picture) { FactoryGirl.create(:picture) }
		let(:user) { FactoryGirl.create(:user) }

		before do
			sign_in(user)
		end

		it 'renders :edit template' do
			get :edit, id: picture.id

			expect(response).to render_template(:edit)
		end

		it 'assigns @picture' do
			get :edit, id: picture.id

			expect(assigns(:picture)).to eq(picture)
		end

	end

	describe 'PUT update' do

		let(:picture) { FactoryGirl.create(:picture)}
		let(:user) { FactoryGirl.create(:user) }

		before do
			sign_in(user)
		end

		context 'valid data' do
			let(:valid_data) { FactoryGirl.attributes_for(:picture)}			
			it 'redirects to picture#show' do
				put :update, id: picture.id, picture: valid_data

				expect(response).to redirect_to(picture)
			end

			it 'update picture in the database' do

			end
		end
		
		context 'invalid data' do
			#let(:invalid_data) { FactoryGirl.attributes_for(:picture, image: fixture_file_upload('/spec/files/images/test.jpg'))}
		end

	end

end