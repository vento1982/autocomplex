require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do

	shared_examples "public access to product" do 
		describe "GET index" do
			it "renders :index template" do
				get :index
				expect(response).to render_template(:index)
			end
		end

		describe "GET show" do
			it "renders :show template" do
				get :show, id: FactoryGirl.create(:product)
				expect(response).to render_template(:show)
			end
		end
	end

	describe "guest user" do

		it_behaves_like "public access to product"

		describe "GET new" do
			it "redirects to login page" do
				get :new
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "POST create" do
			it "redirect to login page" do
				post :create, product: FactoryGirl.attributes_for(:product)
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "GET edit" do
			it "redirect to login page" do
				get :edit, id: FactoryGirl.create(:product)
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "PUT update" do
			it "redirect to login page" do
				put :update, id: FactoryGirl.create(:product), product: FactoryGirl.attributes_for(:product)
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "DELETE destroy" do
			it "redirect to login page" do
				delete :destroy, id: FactoryGirl.create(:product)
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "authenticate user" do
		let(:user) { FactoryGirl.create(:user) }
		
		before do
			sign_in(user)
		end	

		it_behaves_like "public access to product"
		
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

		context "is not the owner of the product" do
			describe "GET edit" do
				it "redirects to products page" do
					get :edit, id: FactoryGirl.create(:product)
					expect(response).to redirect_to(admin_products_path)
				end
			end
			describe "PUT update" do
				it "redirect to products page" do
					put :update, id: FactoryGirl.create(:product), product: FactoryGirl.attributes_for(:product)
					expect(response).to redirect_to(admin_products_path)
				end
			end
			describe "DELETE destroy" do
				it "redirect to products page" do
					delete :destroy, id: FactoryGirl.create(:product)
					expect(response).to redirect_to(admin_products_path)
				end
			end
		end

		context "is the owner of the product" do 
			let(:product) { FactoryGirl.create(:product, user: user) }

			describe "GET edit" do
				it "renders :edit page" do
					get :edit, id: product
					expect(response).to render_template(:edit)
				end
				it "assigns products to template" do
					get :edit, id: product
					expect(assigns(:product)).to eq(product)
				end
			end

			describe "PUT update" do
				context "valid data" do
					let(:valid_data) { FactoryGirl.attributes_for(:product, title: "New title")}
					
					it "redirect to product" do
						put :update, id: product, product: valid_data
						expect(response).to redirect_to(admin_product_path(product))
					end
					it "updata product in the database" do
						put :update, id: product, product: valid_data
						product.reload
						expect(product.title).to eq("New title")
					end
				end
				context "invalid data" do
					let(:invalid_data) { FactoryGirl.attributes_for(:product, title: "", description: "new desc") }

					it "renders :edit template" do
						put :update, id: product, product: invalid_data
						expect(response).to render_template(:edit)
					end
					it "dosen't change product in database" do
						put :update, id: product, product: invalid_data
						product.reload
						expect(product.description).not_to eq("new")
					end
				end
			end

			describe "DELETE destroy" do
				it "redirect to products page" do
					delete :destroy, id: product
					expect(response).to redirect_to(root_path)
				end
				it "deletes product from database" do
					delete :destroy, id: product
					expect(Product.count).to eq(0)
				end
			end
		end
	end
end