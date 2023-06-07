class Inventory < ApplicationRecord
  # relations
  belongs_to :user
  has_many :inventory_ingredients, dependent: :destroy
  has_many :ingredients, through: :inventory_ingredients

  validates :user, presence: true
end
