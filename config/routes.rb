Rails.application.routes.draw do
  get 'ims/main'
  devise_for :users
  resources :users
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

  get 'ims/chart_data', to: 'ims#chart_data'

end
