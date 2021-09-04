class AddDirectionColumnToTradesTable < ActiveRecord::Migration[6.1]
  def change
    add_column  :trades, :direction, :string
  end
end
