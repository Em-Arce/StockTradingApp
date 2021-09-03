class ChangeLatestPriceFromIntegerToDecimalAndAddQtyToStocksTable < ActiveRecord::Migration[6.1]
  def change
    change_column :stocks, :latest_price, "numeric USING CAST(latest_price AS numeric)"
    change_column :stocks, :latest_price, :decimal, precision: 10, scale: 2
    add_column  :stocks, :quantity, :integer
  end
end
