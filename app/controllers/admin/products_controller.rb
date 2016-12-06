class Admin::ProductsController < Admin::BaseController
	before_action :find_product, only: [:show, :edit, :update, :destroy]

	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def show
	end

	def edit
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			redirect_to admin_product_path(@product), notice: 'Product has been created'
		else
			render :new
		end
	end

	def update
		if @product.update_attributes(product_params)
			redirect_to admin_product_path(@product)
		else
			render :edit
		end
	end

	def destroy
		@product.delete
		redirect_to root_path
	end

	private

	def product_params
		params.require(:product).permit(:title, :description)
	end

	def find_product
		@product = Product.find(params[:id])
	end
end