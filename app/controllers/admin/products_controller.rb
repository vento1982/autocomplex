class Admin::ProductsController < Admin::BaseController
	before_action :find_product, only: [:show, :edit, :update, :destroy]
	#before_action :only_owners, only: [ :edit, :update, :destroy ]

	def index
		#render text: params
		@q = Product.ransack(params[:q])
		@products = @q.result(distinct: true)
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
		@product.user_id = current_user.id
		
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
		if @product.destroy
			redirect_to admin_products_path
		end
	end

	private

	def product_params
		params.require(:product).permit(:title, :description)
	end

	def find_product
		@product = Product.find(params[:id])
	end

	def only_owners
		if current_user.id != @product.user_id
			redirect_to(admin_products_path)
		end
	end

end