class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :ingredients, through: :shopping_list_ingredients
end
