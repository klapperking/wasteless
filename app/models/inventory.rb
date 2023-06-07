class Inventory < ApplicationRecord
  # relations
  belongs_to :user
  has_many :inventory_ingredients
  has_many :ingredients, through: :inventory_ingredients
end
