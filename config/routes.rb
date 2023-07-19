Rails.application.routes.draw do
  get 'ims/main'
  devise_for :users
  get 'home/index'
  resources :sales
  resources :purchases
  resources :products do
    get 'getProduct', to: 'products#getProduct'
  end
  resources :suppliers do
    get 'products', to: 'suppliers#products'
  end
  root "home#index"


end
