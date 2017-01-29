require 'rails_helper'

RSpec.describe "routing to products", :type => :routing do

  it "routes / to products#index" do
    expect(:get => "/").to route_to(
      :controller => "products",
      :action => "index"
    )
  end

end