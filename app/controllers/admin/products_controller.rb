class Admin::ProductsController < Admin::BaseController

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			redirect_to admin_product_path(@product)
		else
			render :new
		end
	end

	def show
		@product = Product.find(params[:id])
	end

	

	private

	def product_params
		params.require(:product).permit(:title, :description)
	end
end