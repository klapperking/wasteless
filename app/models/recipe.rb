class Recipe < ApplicationRecord
  # relations
  belongs_to :user
  has_many :ingredients, through: :recipe_ingredients

  # validations
  validates :user, presence: true
  validates :name, presence: true
  validates :desription
  validates :number_of_people
end
