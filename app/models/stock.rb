class Stock < ApplicationRecord
  has_many :trades, dependent: :destroy
  has_many :users, through: :trades, dependent: :destroy
  validates :symbol, uniqueness: true, on: :create
end
