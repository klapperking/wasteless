class ShoppingListsController < ApplicationController
  def show
    # get shopping list of current user
    @shopping_list = policy_scope(ShoppingList)

    # get all the ingredients of that shopping list
    @shoppinglist_ingredients = @shopping_list.shopping_list_ingredients
    @ingredients = @shopping_list.ingredients

    # get all categories for each of the referenced ingredients
    @categories = []

    @shoppinglist_ingredients.each do |shop_ingredient|
      category_name = shop_ingredient.ingredient.category.name
      @categories.push(category_name) unless @categories.include?(category_name)
    end

    # possibly missing auth for other view-vars?
    authorize @shopping_list
  end
end
