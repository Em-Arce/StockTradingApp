class Stock < ApplicationRecord
  has_many :trades, dependent: :destroy
  has_many :users, through: :trades, dependent: :destroy
  validates :symbol, uniqueness: true, on: :create

  def subtract_quantity(number)
    self.quantity = quantity - number
    self.save!
  end
end
