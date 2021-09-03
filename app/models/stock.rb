class Stock < ApplicationRecord
  validates :symbol, uniqueness: true, on: :create
end
