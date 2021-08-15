class AddAdminBrokerBuyerColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :broker, :boolean
    add_column :users, :buyer, :boolean
  end
end
