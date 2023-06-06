class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :measuring_unit
      t.integer :days_to_expiry

      t.timestamps
    end
  end
end
