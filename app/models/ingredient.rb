class Ingredient < ApplicationRecord
  # relations
  belongs_to :category

  # validations
  validates :name, presence: true

  def expiry_date_from(date)
    date + category.days_to_expiry
  end
end
