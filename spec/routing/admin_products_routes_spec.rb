require 'rails_helper'

RSpec.describe "routing to admin products", :type => :routing do

   it "routes /admin to admin/products#index" do
    expect(:get => "/admin").to route_to(
      :controller => "admin/products",
      :action => "index"
      )
  end

  it "routes admin/products/new to admin/products#new" do
    expect(:get => "admin/products/new").to route_to(
      :controller =>  "admin/products",
      :action => "new"
      )
  end
  it 'routes admin/products/:id to admin/products#show' do
    expect(:get => 'admin/products/1').to route_to(
      :controller => 'admin/products',
      :action => 'show',
      :id => '1'
      )
  end

  it 'routes admin/products/:id/edit to admin/products#edit' do
    expect(:get => 'admin/products/1/edit').to route_to(
      :controller => 'admin/products',
      :action => 'edit',
      :id => '1'
      )
  end

  it 'routes admin/products/:id to admin/products#update' do
    expect(:patch => 'admin/products/1').to route_to(
      :controller => 'admin/products',
      :action => 'update',
      :id => '1'
      )
  end

  it 'routes admin/products/:id to admin/products#destroy' do
    expect(:delete => 'admin/products/1').to route_to(
      :controller => 'admin/products',
      :action => 'destroy',
      :id => '1'
      )
  end

end