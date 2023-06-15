class RecipeIngredient < ApplicationRecord
  # relations
  belongs_to :ingredient
  belongs_to :recipe

  # validations
  validates :ingredient, presence: true
  validates :recipe, presence: true
  validates :quantity, presence: true, numericality: true

  def format_float
    quantity % 1 == 0 ? quantity.to_i : quantity
  end
end
