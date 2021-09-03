class AddCashToUsersTable < ActiveRecord::Migration[6.1]
  def change
    add_column  :users, :cash, :decimal, precision: 10, scale: 2
  end
end
