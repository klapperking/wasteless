class InventoryIngredient < ApplicationRecord
  include ActiveModel::Validations

  # callbacks
  before_validation :set_expiration_date

  # relations
  belongs_to :ingredient
  belongs_to :inventory

  # validations
  validates :ingredient, presence: true
  validates :inventory, presence: true
  validates :quantity, presence: true, numericality: true

  # validate the expirations date to be in the future
  validates_with InventoryIngredientValidator

  def format_float
    quantity % 1 == 0 ? quantity.to_i : quantity
  end

  private

  def set_expiration_date
    self.expiration_date = ingredient.expiry_date_from(Date.today) unless expiration_date
  end
end
