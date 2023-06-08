class InventoryIngredientValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add('No expiration date set') unless record.expiration_date.present?

    record.errors.add('Expiration date is in the past') if record.expiration_date < Date.today
  end
end
