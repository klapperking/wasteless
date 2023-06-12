Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/recipe/confirmation', to: 'pages#confirmation'

  resources :inventories, only: [:show] do
    resources :inventory_ingredients, only: %i[new create edit update destroy]
  end

  resources :inventory_ingredients, only: %i[edit update destroy]

  # routes for recipes
  resources :recipes, only: %i[index show]

  # routes for shopping list
  resources :shopping_lists, only: [:show]
  post 'shopping_lists/:shopping_list_id/add_recipe/:id', to: 'shopping_lists#add_from_recipe', as: 'add_recipe_to_list'

  # routes for adding a recipe to shopping list
  resources :shopping_list_ingredients, only: %i[create]
end
