class ChangeQuantityInInventoryIngredients < ActiveRecord::Migration[7.0]
  def change
    change_column :inventory_ingredients, :quantity, :float
  end
end
