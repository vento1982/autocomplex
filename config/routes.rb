Rails.application.routes.draw do
  devise_for :users, path: 'admin'
  
  namespace :admin do
  
    root to: "products#index"
    resources :products
    resources :pictures
    resources :ads

    resources :jobs do 
      member do
        patch :complete
        patch :uncomplete
      end
    end

  end

  root to: "products#index"
  resources :products
  resources :pictures

  resources :ads do
    resources :jobs
  end

  match '/contacts', to: 'contacts#new', via: 'get'
  resources "contacts", only: [:new, :create]
  
  get 'o-nas', to: 'static#about', as: :about
  #get 'kontakt', to: "static#contact", as: :contact
end
