class RemoveNameFromInventories < ActiveRecord::Migration[7.0]
  def change
    remove_column :inventories, :name
  end
end
