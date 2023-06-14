class RecipesController < ApplicationController

  def index
    # get recipes for current_user
    @recipes = policy_scope(Recipe)

    # number of ingredient available
    @inventory = Inventory.find_by(user: current_user)
    @inventory_ingredients = @inventory.inventory_ingredients
    @inventory_ingredients_ingredients = @inventory_ingredients.map { |inventory_ingredient| inventory_ingredient.ingredient}
    # If called with ingredient query, find best match for ingredient ids and order recipes by matchcount
    if params.key?(:ingredients)
      # Example query: /?ingredients={ing_id},{ing_id}
      @ingredients = params[:ingredients].split(',').map { |ingr_id| Ingredient.find(ingr_id) }
      @match_order = rank_recipes()
    end
    authorize @recipes
  end

  def show
    @recipe = Recipe.find(params[:id])
    @inventory = Inventory.find_by(user: current_user)
    @inventory_ingredients = @inventory.inventory_ingredients
    @inventory_ingredients_ingredients = @inventory_ingredients.map { |inventory_ingredient| inventory_ingredient.ingredient}

    @shopping_list = ShoppingList.find_by(user: current_user)

    authorize @recipe
  end

  private

  def rank_recipes
    # create recipe order hash { recipe_id: match_count }
    match_tally = {}

    # for each recipe, count matches of selected ingredients
    @recipes.each do |recipe|
      match_tally[recipe] = 0

      @ingredients.each do |ingredient|
        match_tally[recipe] += 1 if recipe.ingredients.include?(ingredient)
      end
    end

    # order @recipes by their respective count (descending) TODO inplace sort the @recipes pseudo-array
    match_tally = match_tally.sort_by { |_key, value| -value }.to_h
    return match_tally
  end
end
