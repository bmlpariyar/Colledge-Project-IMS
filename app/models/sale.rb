class Sale < ApplicationRecord
  belongs_to :product
  has_one :supplier, through: :product
end