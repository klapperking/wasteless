class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]
  before_action :confirmation_params, only: [:confirmation]

  def home
    @inventory = Inventory.find(current_user.id)
    @recipe = Recipe.last
    @ingredients = @inventory.inventory_ingredients
    @my_ingredients = { "Less than 2 days" => @ingredients.select { |ingredient| ingredient.expiration_date <= Date.today + 2}.count,
     "2 - 4 days" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 2 && ingredient.expiration_date <= Date.today + 4}.count,
     "5 - 7 days" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 4 && ingredient.expiration_date <= Date.today + 7}.count,
     "1 - 2 weeks" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 7 && ingredient.expiration_date <= Date.today + 14}.count,
     "2 - 4 weeks" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 14 && ingredient.expiration_date <= Date.today + 30}.count,
     "More than a month" => @ingredients.select { |ingredient| ingredient.expiration_date > Date.today + 30}.count }
  end

  def confirmation
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
  end

  private

  def confirmation_params
    params.permit!
  end
end
