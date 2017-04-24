class Admin::JobsController < Admin::BaseController

	def index
		@q = Job.ransack(params[:q])
		@jobs = @q.result(distinct: true).page(params[:page]).per(20)
	end

	def destroy

	end

	def complete
		@job = Job.find(params[:id])
		@job.update_attribute(:completed_at, Time.now)
		redirect_to admin_jobs_path, notice: 'Job has been completed.'
	end

end
