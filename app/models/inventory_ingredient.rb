class InventoryIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :inventory
end
