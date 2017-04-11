class JobsController < ApplicationController
	
	def create
		@ad = Ad.find(params[:ad_id])
		@job = @ad.jobs.create(job_params)

		if @job.save
			redirect_to ads_path
			flash[:notice] = 'Thank you for your apply.'
		else
			render 'ads/show'
			flash[:error] = 'Cannot send message.'
		end
	end

	private

	def job_params
		params.require(:job).permit(:name,:email,:message)
	end
end
