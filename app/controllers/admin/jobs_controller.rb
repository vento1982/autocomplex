class Admin::JobsController < Admin::BaseController

	def index
		@q = Job.ransack(params[:q])
		@jobs = @q.result(distinct: true).page(params[:page]).per(20)
	end

	def show
		@job = Job.find(params[:id])
	end

	def destroy
		@job = Job.find(params[:id])
		if @job.destroy
			redirect_to admin_jobs_path, notice: 'Job has been deleted.'
		end
	end

	def complete
		@job = Job.find(params[:id])
		@job.update_attribute(:completed_at, Time.now)
		redirect_to admin_jobs_path, notice: 'Job has been completed.'
	end

	def uncomplete
		@job = Job.find(params[:id])
		@job.update_attribute(:completed_at, nil)
		redirect_to admin_jobs_path, notice: 'Job has been uncompleted.'
	end

end
