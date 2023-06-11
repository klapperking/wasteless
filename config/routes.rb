Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/recipe/confirmation', to: 'pages#confirmation'

  resources :inventories, only: [:show] do
    resources :inventory_ingredients, only: %i[new create edit update destroy]
  end

  resources :inventory_ingredients, only: %i[edit update destroy]

  # routes for recipes
  resources :recipes, only: [:index]

  # routes for shopping list
  resources :shopping_lists, only: [:show]

  # api endpoint for algolia-search searhc API-Key
  get 'api/environment_variables', to: 'apis#environment_variables'
end
