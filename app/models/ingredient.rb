class Ingredient < ApplicationRecord
  include AlgoliaSearch

  algoliasearch do
    attributes :name
  end

  # relations
  belongs_to :category
  has_many :inventory_ingredients, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :shopping_list_ingredients, dependent: :destroy

  # validations
  validates :name, presence: true

  def expiry_date_from(date)
    # calculate the expiry date
    date + category.days_to_expiry
  end
end
