class Admin::PicturesController < Admin::BaseController

	before_action :find_picture, only: [:show, :edit, :update, :destroy]

	def index
		@q = Picture.ransack(params[:q])
		@pictures = @q.result(distinct: true)
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

	def show
		
	end

	def edit
	end

	def update
		if @picture.update_attributes(picture_params)
			redirect_to admin_picture_path(@picture)
		end
	end

	def destroy
		if @picture.destroy
			redirect_to admin_pictures_path
		end
	end


	private

	def picture_params
		params.require(:picture).permit(:name,:image,:user)
	end

	def find_picture
		@picture = Picture.find(params[:id])
	end
	
end