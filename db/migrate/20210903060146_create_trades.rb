class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades do |t|
      t.references :stock, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :purchase_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
