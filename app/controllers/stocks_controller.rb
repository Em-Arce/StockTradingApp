class StocksController < ApplicationController
  def index
    @user = current_user
    @stocks = Stock.all
  end
end
