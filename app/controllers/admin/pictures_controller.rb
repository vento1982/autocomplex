class Admin::PicturesController < Admin::BaseController
	
	def index
		@pictures = Picture.all
	end
	
	def new
		@picture = Picture.new
	end

	def create
		@picture = Picture.new(picture_params)
		@picture.user_id = current_user.id

		if @picture.save
			redirect_to admin_pictures_path, notice: 'Picture has been created'
		else
			render :new
		end
	end



	private

	def picture_params
		params.require(:picture).permit(:name,:image,:user)
	end
	
end