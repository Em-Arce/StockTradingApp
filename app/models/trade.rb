class Trade < ApplicationRecord
  belongs_to :stock
  belongs_to :user

  validates_numericality_of :quantity, only_integer: true
end
