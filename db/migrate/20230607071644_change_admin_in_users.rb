class ChangeAdminInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :admin, :boolean, null: false, default: false
  end
end
