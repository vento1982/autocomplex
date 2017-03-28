class Admin::AdsController < Admin::BaseController 

	before_action :find_ad, only: [:show, :edit, :update, :destroy]

	def index
		@q = Ad.ransack(params[:q])
		@ads = @q.result(distinct: true).page(params[:page]).per(20)
	end

	def new
		@ad = Ad.new
	end

	def show
	end

	def edit
	end

	def update
		if @ad.update_attributes(ad_params)
			redirect_to admin_ad_path(@ad)
		else
			render :edit
		end
	end

	def create
		@ad =Ad.new(ad_params)
		@ad.user_id = current_user.id
		if @ad.save
			redirect_to admin_ads_path, notice: 'Ad has been created.'
		else
			render :new
		end
	end

	def destroy
		@ad.destroy
		redirect_to admin_ads_path , notice: 'Ad has been deleted.'
		
	end

	private

	def find_ad
		@ad = Ad.find(params[:id])
	end

	def ad_params
		params.require(:ad).permit(:title, :description, :validity, :user)
	end

end