class Category < ApplicationRecord
  # relations
  has_many :ingredients

  # validations
  validates :name, presence: true, uniqueness: true

  validates :measuring_unit, presence: true

  validates :days_to_expiry,  presence: true,
                              numericality: {
                                only_integer: true,
                                message: "Days can only be integer"
                              }
end
