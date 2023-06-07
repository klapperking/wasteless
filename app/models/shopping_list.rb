class ShoppingList < ApplicationRecord
  # relations
  belongs_to :user
  has_many :shopping_list_ingredients, dependent: :destroy
  has_many :ingredients, through: :shopping_list_ingredients

  # validations
  validates :user, presence: true
end
