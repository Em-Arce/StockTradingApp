class Role < ApplicationRecord
  has_many :role_users, dependent: :destroy
  has_many :users, through: :role_users, dependent: :destroy
end
