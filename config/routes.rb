Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/recipe/confirmation', to: 'pages#confirmation'
  post '/shopping-list/done', to: 'inventory_ingredients#modify', as: :modify

  resources :inventories, only: [:show] do
    resources :inventory_ingredients, only: %i[new create edit update destroy]
  end

  resources :inventory_ingredients, only: %i[edit update destroy]

  # routes for recipes
  resources :recipes, only: [:index]

  # routes for shopping list
  resources :shopping_lists, only: [:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
