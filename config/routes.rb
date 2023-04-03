Rails.application.routes.draw do
  # get '/categories/:id', to: 'categories#show'
  # get 'categories/:slug', to: 'application#get_category_name'
  resources :categories, only: [:show]
  resources :articles
  devise_for :users
  root 'articles#index'
  # root 'articles#index', :path_prefix => '/:locale'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
