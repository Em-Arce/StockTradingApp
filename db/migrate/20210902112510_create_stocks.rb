class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.integer :latest_price #real_time_price
      t.datetime :latest_time #time of latest_price

      t.timestamps
    end
  end
end
