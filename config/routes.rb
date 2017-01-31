Rails.application.routes.draw do
  devise_for :users, path: 'admin'
  namespace :admin do
    root to: "products#index"
    resources :products
  end

  root to: "products#index"
  resources :products
  get 'o-nas', to: 'static#about', as: :about
  get 'kontakt', to: "static#contact", as: :contact
end
