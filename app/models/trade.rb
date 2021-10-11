class Trade < ApplicationRecord
  belongs_to :stock
  belongs_to :user
  TYPES = %w(buy sell)

  validates_numericality_of :quantity, only_integer: true
  validates :direction, :inclusion => {:in => TYPES}

  def get_total_quantity(current_user)
    self.trades = User.find(current_user.id)
    #binding.pry
    self.trades.to_a.group_by(&:stock_id).map{|stock_id, trades|{:stock_id => stock_id.to_i, :quantity => trades.sum {|q| q.quantity.to_i}}}
    self.save!
  end

  #retrieve stocks owned by user through his trades and add the stock name and symbol for the portfolio page
  def get_stock_info(user)
    trades = Trade.where(user_id: user.id)
    trade_ids = trades.pluck(:stock_id).uniq!
    #group trades by stock id and get sum of qty
    trades_summary = trades.to_a.group_by(&:stock_id).map{|stock_id, trades|{:stock_id => stock_id.to_i,
    :quantity => trades.sum {|q| q.quantity.to_i} }}

    trades_summary.each do |trade|
      trade[:stock_name] = Stock.find_by(id:trade[:stock_id]).name
      trade[:stock_symbol] = Stock.find_by(id:trade[:stock_id]).symbol
    end

    return trades_summary
    #binding.pry
    #puts "hello"
  end
end
