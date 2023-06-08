class ShoppingListsController < ApplicationController
  def show
    @shoppinglist_ingredients = ShoppingListIngredient.find(current_user.id)
    @shopping_list = ShoppingList.find(current_user.id)
    @ingredients = @shopping_list.ingredients
    @categories = []
    @ingredients_name = []
    @ingredients.each do |ingredient|
      @categories << ingredient.category.name
    end
    @categories.uniq!
    authorize @shopping_list
  end
end
