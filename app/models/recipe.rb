class Recipe < ApplicationRecord
  # relations
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :to_be_cookeds, dependent: :nullify # When recipe deleted, don't delete from to be cooked
  has_many :ingredients, through: :recipe_ingredients

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
