class TradesController < ApplicationController

def index
  @user = current_user
  @trades = @user.trades ||= nil
  trades = @trades
  @formatted_trades = trades.to_a.group_by(&:stock_id).map{|stock_id, trades|{:stock_id => stock_id.to_i,
    :quantity => trades.sum {|q| q.quantity.to_i} }}
    #:ave_purchase_price => trades.sum {|p,q| p.purchase_price.to_d}/q.quantity.to_i
  #binding.pry
end

def new
  @user = current_user
  @trade = @user.trades.build
end

def create
  @user = current_user
  @trade = @user.trades.create(trade_params)

  client = IEX::Api::Client.new(publishable_token: "pk_cb0a3e2c28634560a2b4ae0544e36a1f",
      endpoint: 'https://cloud.iexapis.com/v1')

  # find the stock chosen from database
  stock = Stock.find(params[:trade][:stock_id])

  #get the latest quote price of chosen stock
  stock_price = client.quote(stock.symbol).latest_price

  #calculate and compare to user.cash
  total_price = stock_price * params[:trade][:quantity].to_i

  if @user.cash > total_price
    if @trade.direction == "buy"
      #hardcode the latest price not the one entered by user
      @trade.update!(purchase_price: stock_price)

      #subtract the total_price from cash
      @user.update_cash(total_price)

      #subtract the qty from stock
      stock.subtract_quantity(params[:trade][:quantity].to_i)
      #binding.pry
      redirect_to user_trades_path(current_user.id), notice: "Trade completed."
    elsif @trade.direction == "sell"
      redirect_to user_trades_path(current_user.id), notice: "Watch out for the release of sell feature!"
    end
  else
    redirect_to user_trades_path(current_user.id), notice: "Insufficient cash. This trade costs $#{(total_price - @user.cash).truncate(2)} more than the cash you have."
  end
end

private
  def trade_params
    params.require(:trade).permit(:stock_id, :user_id, :quantity, :purchase_price, :direction)
  end
end
