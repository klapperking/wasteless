class InventoryIngredient < ApplicationRecord
  # callbacks
  after_validation :set_expiration_date

  # relations
  belongs_to :ingredient
  belongs_to :inventory

  # validations
  validates :quantity, presence: true
  validates_with :quantity_valid_float?

  def set_expiration_date
    # get expiration date from the ingredient category
    this.expiration_date = ingredient.expiry_date_from(Date.today)
  end

  private

  def quantity_valid_float?
    !!Float(quantity) rescue false
  end
end
