class ProductsController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :delete]
	before_action :find_product, only: [:show]

	def index
		@products = Product.all
		render layout: 'jumbotron'
	end

	def show
		@products = Product.all
		render layout: 'application'
	end

	private

	def find_product
		@product = Product.find(params[:id])
	end

end
