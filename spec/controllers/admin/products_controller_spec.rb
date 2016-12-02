require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
	describe "GET new" do 
		
		it "renders :new template" do
			get :new
			expect(response).to render_template(:new)
		end

		it "assigns new product to @product" do
			get :new
			expect(assigns(:product)).to be_a_new(Product)
		end
	end

	describe "GET show" do
		let(:product) { FactoryGirl.create(:product) }
		
		it "renders :show template" do
			get :show, id: product.id
			expect(response).to render_template(:show)
		end

		it "assigns requested product to @product" do
			get :show, id: product.id
			expect(assigns(:product)).to eq(product)
		end
	end

	describe "POST create" do
		context "valid data" do
			let(:valid_data) { FactoryGirl.attributes_for(:product) }
			
			it "redirects to product#show" do
				post :create, product: valid_data

				expect(response).to redirect_to(admin_product_path(assigns[:product]))
			end

			it "creates new product in database" do
				expect{
					post :create, product: valid_data
				}.to change(Product, :count).by(1)
			end
		end
		context "invalid data" do
			let(:invalid_data) { FactoryGirl.attributes_for(:product, title: "") }

			it "renders :new template" do
				post :create, product: invalid_data
				expect(response).to render_template(:new)
			end
			it "dosen't create new prooduct in the database" do
				expect{
					post :create, product: invalid_data
				}.not_to change(Product, :count)
			end
		end
	end
end
	