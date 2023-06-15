class ShoppingListIngredient < ApplicationRecord
  # relations
  belongs_to :ingredient
  belongs_to :shopping_list

  # validations
  validates :ingredient, presence: true
  validates :shopping_list, presence: true
  validates :quantity, presence: true

  def format_float
    quantity % 1 == 0 ? quantity.to_i : quantity
  end
end
