class AddRoleNamesToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role_names, :string
  end
end
