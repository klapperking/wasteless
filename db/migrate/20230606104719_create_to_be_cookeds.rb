class CreateToBeCookeds < ActiveRecord::Migration[7.0]
  def change
    create_table :to_be_cookeds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipes, null: false, foreign_key: true

      t.timestamps
    end
  end
end
