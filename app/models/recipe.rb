class Recipe < ApplicationRecord
  # relations
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :to_be_cookeds, dependent: :destroy # Don't destroy from cooking-list if recipe is gone
  has_many :ingredients, through: :recipe_ingredients

  has_one_attached :photo

  # validations
  validates :user, presence: true
  validates :name, presence: true
  validates :description, presence: true,
                          length: {
                            minimum: 10,
                            message: "Must be at least 10 characters"
                          }

  validates :number_of_people, numericality: { only_integer: true }
end
