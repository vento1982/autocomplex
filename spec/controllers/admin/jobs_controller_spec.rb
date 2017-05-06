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

			it 'assigns flash message' do
				patch :complete, id: job
				
				expect(flash[:notice]).to eq 'Job has been completed.'
			end

		end
	end

	describe 'PATCH uncomplete' do

		context 'quest user' do

			let(:job) { FactoryGirl.create(:job) }

			it 'redirect to login page' do
				patch :uncomplete, id: job
				
				expect(response).to redirect_to new_user_session_path
			end

			it 'assigns flash message' do
				patch :uncomplete, id: job
				
				expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
			end

		end

		context 'authenticate user' do

			let(:user) { FactoryGirl.create(:user)}
			let(:job) { FactoryGirl.create(:job, completed_at: Time.now) }
			let(:uncomplete) { FactoryGirl.attributes_for(:job)}

			before do
				sign_in(user)
			end

			it 'redirects to jobs page' do
				patch :uncomplete, id: job
				
				expect(response).to redirect_to admin_jobs_path
			end

			it 'assigns @job' do
				patch :uncomplete, id: job
				
				expect(assigns[:job]).to eq job
			end

			it 'deletes datatime in the database' do
				patch :uncomplete, id: job, job: uncomplete
				job.reload
				
				expect(job.completed_at).to eq(nil) 
			end

				it 'assigns flash message' do
				patch :uncomplete, id: job
				
				expect(flash[:notice]).to eq 'Job has been uncompleted.'
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
				delete :destroy, id: job
				expect(Job.exists?(job.id)).to be_falsy
			end

			it 'redirect to jobs page' do
				delete :destroy, id: job
				expect(response).to redirect_to admin_jobs_path
			end

			it 'assigns flash message' do
				delete :destroy, id: job
				expect(flash[:notice]).to eq 'Job has been deleted.'
			end

		end

	end

	describe 'GET show' do

		context 'guest user' do

			let(:job) { FactoryGirl.create(:job) }

			it 'redirects to login page' do
				get :show, id: job
				expect(response).to redirect_to new_user_session_path
			end

			it 'assigns flash message' do
				get :show, id: job
				expect(flash[:alert]).to eq 'You need to sign in or sign up before continuing.'
			end

			it 'not assigns @job' do
				get :show, id: job
				expect(assigns(:job)).to eq(nil)
			end
		end

		context 'authenticate user' do
			
			let(:job) { FactoryGirl.create(:job) }
			let(:user) { FactoryGirl.create(:user) }

			before do
				sign_in(user)
			end

			it 'renders :show template' do
				get :show, id: job
				expect(response).to render_template(:show)
			end

			it 'assigns @job' do
				get :show, id: job
				expect(assigns(:job)).to eq(job)
			end
		end
	end
end
