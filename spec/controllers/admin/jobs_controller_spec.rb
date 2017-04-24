require 'rails_helper'

RSpec.describe Admin::JobsController, type: :controller do

	describe 'GET index' do

		context 'guest user' do

			it 'redirect to login page' do
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

			it 'response succesfull with HTTP status 200' do
				get :index
				expect(response).to be_success
				expect(response).to have_http_status(200)

			end

			it 'renders :index template' do
				get :index 
				expect(response).to render_template :index
			end

			it 'assigns @jobs' do
				job1 = FactoryGirl.create(:job)
				job2 = FactoryGirl.create(:job) 

				get :index
				expect(assigns(:jobs)).to match_array([job1,job2])
			end


		end

	end

	describe 'PATCH complete' do

		context 'guest user' do
			
			let(:job) { FactoryGirl.create(:job) }
			
			it 'redirect to login page' do
				patch :complete, id: job.id
				expect(response).to redirect_to new_user_session_path
			end

			it 'assigns flash message' do
				patch :complete, id: job
				expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
			end

		end

		context 'authenticate user' do

			let(:user) { FactoryGirl.create(:user) }
			let(:job) { FactoryGirl.create(:job) }
			let(:completed) { FactoryGirl.attributes_for(:job)}

			before do
				sign_in(user)
			end
			
			it 'redirects to jobs page' do
				patch :complete, id: job
				expect(response).to redirect_to admin_jobs_path
			end

			it 'assigns @job' do
				patch :complete,id: job
				expect(assigns(:job)).to eq job
			end

			it 'fills datetime in the database' do
				patch :complete, id: job, job: completed
				job.reload
				expect(job.completed_at).to eq(Time.now)
			end

		end
	end

	describe 'DELETE destroy' do

		context 'guest user' do

			let(:job) { FactoryGirl.create(:job) }

			it 'redirect to login page' do
				delete :destroy, id: job
				expect(response).to redirect_to new_user_session_path
			end

			it 'assigns flash message' do
				delete :destroy, id: job
				expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
			end

		end

		context 'authenticate user' do

			let(:user) { FactoryGirl.create(:user) }
			let(:job) { FactoryGirl.create(:job) }

			before do
				sign_in(user)
			end

			it 'delete from the database' do

			end

			it 'redirect to jobs page' do
				delete :destroy, id: job
				expect(response).to redirect_to admin_jobs_page
			end

		end

	end
end
