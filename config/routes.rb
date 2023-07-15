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

  


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
