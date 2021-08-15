class AddDefaultToAdminAndBuyer < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :admin, :boolean, :default => false
    change_column :users, :buyer, :boolean, :default => true
  end
end
