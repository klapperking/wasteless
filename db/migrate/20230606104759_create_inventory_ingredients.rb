class CreateInventoryIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_ingredients do |t|
      t.integer :quantity
      t.date :expiration_date
      t.references :ingredient, null: false, foreign_key: true
      t.references :inventory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
