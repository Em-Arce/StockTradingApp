Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get 'static_pages/welcome'
  resources :users
end
