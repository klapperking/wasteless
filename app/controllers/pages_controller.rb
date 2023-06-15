class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]
  before_action :confirmation_params, only: [:confirmation]

  def home
    @inventory = Inventory.find_by(user: current_user)
    @inventory_ingredients = @inventory.inventory_ingredients
    @inventory_ingredients_ingredients = @inventory_ingredients.map { |inventory_ingredient| inventory_ingredient.ingredient}
    @recipe = Recipe.last
    @ingredients = @inventory.inventory_ingredients
    @my_ingredients = { "Expir. less than 2 days" => @ingredients.select { |ingredient| ingredient.expiration_date <= Date.today + 2}.count,
     "Expir. 2/4 days" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 2 && ingredient.expiration_date <= Date.today + 4}.count,
     "Expir. 5/7 days" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 4 && ingredient.expiration_date <= Date.today + 7}.count,
     "Expir. 1/2 weeks" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 7 && ingredient.expiration_date <= Date.today + 14}.count,
     "Expir. 2/4 weeks" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 14 && ingredient.expiration_date <= Date.today + 30}.count,
     "Expir. more than 1 month" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 30}.count }
  end

  def confirmation
    # get all ingredients
    @inventory = Inventory.find_by(user: current_user)
    @inventory_ingredients = @inventory.inventory_ingredients
    @inventory_ingredients_ingredients = @inventory_ingredients.map { |inventory_ingredient| inventory_ingredient.ingredient}

    # get recipe to display
    @recipe = Recipe.find(params[:recipe])

    # get inventory_ingredients that were updated from params
    if params.key?(:inventory)
      inventory_params = params[:inventory]
      # raise
      @inventory_ingredients = inventory_params.to_h.transform_keys! { |ing_id| Ingredient.find(ing_id) }
    else
      @inventory_ingredients = {}
    end

    # get shopping_list_ingredirents that were added
    if params.key?(:shopping_list)
      shopping_list_params = params[:shopping_list]
      @shopping_list_ingredients = shopping_list_params.transform_keys! { |ing_id| Ingredient.find(ing_id) }
    else
      @shopping_list_ingredients = {}
    end

    flash.notice = 'Wasteless updated !'
  end

  private

  def confirmation_params
    params.permit!
  end
end
