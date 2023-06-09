class RecipesController < ApplicationController

  def index
    # get restaurants for current_user
    @recipes = policy_scope(Recipe)

    # If called with ingredient query, find best match for ingredient ids and order recipes by matchcount
    if params.key?(:ingredients)
      # Example query /?query={ingredient_id}-{quantity}+... e.g.: /?query=1-2
      @ingredients = params[:ingredients].split(',').map { |ingr_id| Ingredient.find(ingr_id) }

      # create recipe order hash { recipe_id: match_count }
      @match_order = {}
      @recipes.each { |recipe| @match_order[recipe] = 0 }

      # increment match counter for each recipe if it includes a given ingredient (iterate all selected ingr)
      @recipes.each do |recipe|
        @ingredients.each do |ingredient|
          @match_order[recipe] += 1 if recipe.ingredients.include?(ingredient)
        end
      end

      # order @recipes by their respective count (Unforunately using a helpder hash - To be reworked)
      @match_order = @match_order.sort_by { |_key, value| -value }.to_h
    end
    authorize @recipes
  end
end
