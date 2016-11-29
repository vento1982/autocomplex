Rails.application.routes.draw do
  root to: "products#index"
  get 'o-nas', to: 'static#about', as: :about
  get 'kontakt', to: "static#contact", as: :contact
end
