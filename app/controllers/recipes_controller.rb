class RecipesController < ApplicationController
  def index
    # get restaurants for current_user
    @recipes = policy_scope(Recipe)
    authorize @recipes
  end
end
