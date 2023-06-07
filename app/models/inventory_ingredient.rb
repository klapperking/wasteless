class InventoryIngredient < ApplicationRecord
  # callbacks
  after_validation :set_expiration_date

  # relations
  belongs_to :ingredient
  belongs_to :inventory

  # validations
  validates :ingredient, presence: true
  validates :inventory, presence: true
  validates :quantity, presence: true, numericality: true

  private

  def set_expiration_date
    self.expiration_date = ingredient.expiry_date_from(Date.today)
  end
end
