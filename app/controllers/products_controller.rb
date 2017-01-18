class ProductsController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :delete]

	def index
		@products = Product.all
	end
end
