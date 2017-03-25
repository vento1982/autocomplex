class Admin::AdsController < Admin::BaseController 

	def index
		@ads = Ad.page(params[:page]).per(20)
	end

	def new
		@ad = Ad.new
	end

	def show
		@ad = Ad.find(params[:id])
	end

	def edit
		@ad = Ad.find(params[:id])
	end

	def update
		@ad = Ad.find(params[:id])

		if @ad.update_attributes(ad_params)
			redirect_to admin_ad_path(@ad)
		else
			render :edit
		end
	end

	def create
		@ad =Ad.new(ad_params)

		if @ad.save
			redirect_to admin_ads_path, notice: 'Ad has been created.'
		else
			render :new
		end
	end

	def destroy
		@ad = Ad.find(params[:id])
		@ad.destroy
		redirect_to admin_ads_path , notice: 'Ad has been deleted.'
		
	end

	private

	def ad_params
		params.require(:ad).permit(:title, :description, :validity)
	end

end