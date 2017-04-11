require 'rails_helper'

RSpec.describe JobsController, type: :controller do

	describe 'GET :new' do
		it 'assigns new job to @job' do
			get :new
			expect(assigns(:job)).to be_a_new(Job)
		end
	end

	describe 'POST :create' 

		context 'valid data' do

			let(:valid_data) { FactoryGirl.attributes_for(:job) }

			it 'redirect to ads_path' do
				post :create, job: valid_data
				expect(response).to redirect_to ads_path
			end

			it 'assigns flash message' do
				post :create, job: valid_data
				expect(flash[:notice]).to eq('Thank you for your apply.')

			end

		end

		context 'invalid data' do
			
			let(:invalid_data) { FactoryGirl.attributes_for(:job, email: "")}
			
			it 'renders :new template' do
				post :create, job: invalid_data
				expect(response).to render_template(:new)
			end
			
			it 'assigns flash message' do
				post :create, job: invalid_data
				expect(flash[:error]).to eq('Cannot send message.')
			end

		end

end
