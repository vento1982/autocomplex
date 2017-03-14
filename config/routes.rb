Rails.application.routes.draw do
  devise_for :users, path: 'admin'
  namespace :admin do
    root to: "products#index"
    resources :products
    resources :pictures
  end

  root to: "products#index"
  resources :products
  resources :pictures
  
  match '/contacts', to: 'contacts#new', via: 'get'
  resources "contacts", only: [:new, :create]
  
  get 'o-nas', to: 'static#about', as: :about
  #get 'kontakt', to: "static#contact", as: :contact
end
