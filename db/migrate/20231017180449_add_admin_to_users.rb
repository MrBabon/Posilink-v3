class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :nickname, :string
    add_column :users, :name, :string
  end
end
