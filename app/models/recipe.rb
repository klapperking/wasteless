class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ingredients, through: :recipe_ingredients
end
