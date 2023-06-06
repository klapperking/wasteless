class Inventory < ApplicationRecord
  belongs_to :user
  has_many :ingredients, through: :inventory_ingredients
end
