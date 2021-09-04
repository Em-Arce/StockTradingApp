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


end
