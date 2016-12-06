require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do

	describe "GET index" do
		it "renders :index template" do
			get :index
			expect(response).to render_template(:index)
		end	
		it "assigns products to template" do
			product = FactoryGirl.create(:product)
			get :index
			expect(assigns(:products)).to match_array([product])
		end
	end

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

	describe "GET edit" do

			let(:product) { FactoryGirl.create(:product) }
			it "renders :edit template" do
				get :edit, id: product.id
				expect(response).to render_template(:edit)		
			end
			it "assigns the requested product to template" do 
				get :edit, id: product.id
				expect(assigns(:product)).to eq(product) 
			end		
	end

	describe "PUT update" do
		
		let(:product) { FactoryGirl.create(:product) }
		context "valid data" do
			
			let(:valid_data) { FactoryGirl.attributes_for(:product, title: "New title", decription: "New description") }
			it "redirect to product" do	
				put :update, id: product, product: valid_data
				expect(response).to redirect_to(admin_product_path(product))
			end
			it "save product in database" do
				put :update, id: product, product: valid_data
				product.reload
				expect(product.title).to eq("New title")
			end
		end

		context "invallid data" do

			let(:invalid_data) { FactoryGirl.attributes_for(:product, title: "", description: "new") }
			it "render :edit template" do 
				put :update, id: product, product: invalid_data
				expect(response).to render_template(:edit)
			end

			it "dosen't update product in database" do
				put :update, id: product, product: invalid_data
				product.reload
				expect(product.description).not_to eq("new") 
			end
		end
	end

	describe "DELETE destroy" do
		
		let(:product) { FactoryGirl.create(:product) }
		it "deletes product from database" do
			delete :destroy, id: product.id
			expect(Product.count).to eq(0)
		end

		it "redirect to product#index" do
			delete :destroy, id: product
			expect(response).to redirect_to(root_path)
		end
	end
end
	