class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @inventory = Inventory.find(current_user.id)
    @recipe = Recipe.last
    @my_pets = { "Less than 2 days" => 12, "2 - 4 days" => 7, "5 - 7 days" => 5, "1 - 2 weeks" => 8, "2 - 4 weeks" => 13, "More than a month" => 6 }
  end

  def confirmation
    # get recipe to display
    @recipe = Recipe.find(params[:recipe])

    # get inventory_ingredients that were updated from params
    if params.key?(:inventory)
      inventory_params = params[:inventory]
      inventory_params.to_h.transform_keys! { |ing_id| Ingredient.find(ing_id) }
      @inventory_ingredients = inventory_params
    else
      @inventory_ingredients = {}
    end

    # get shopping_list_ingredirents that were added
    if params.key?(:shopping_list)
      shopping_list_params = params[:shopping_list]
      shopping_list_params.transform_keys! { |ing_id| Ingredient.find(ing_id) }
      @shopping_list_ingredients = shopping_list_params
    else
      @shopping_list_ingredients = {}
    end
  end
end
