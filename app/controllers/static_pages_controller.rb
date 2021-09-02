class StaticPagesController < ApplicationController
  def welcome
    @stocks = Stock.all
  end
end
