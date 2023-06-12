class ChangeQuantityFromFloatToIntForRecipeIngredientAndShoppingListIngredients < ActiveRecord::Migration[7.0]
  def change
    change_column :recipe_ingredients, :quantity, :float
    change_column :shopping_list_ingredients, :quantity, :float
  end
end
