class Sale < ApplicationRecord
  belongs_to :product
  has_one :supplier, through: :product

  validates :bill_no, presence: true, numericality: { greater_than_or_equal_to: 0, message: "must be greater than 0" }
  validates :date, presence: true
  validates :customer_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "must be alphabetical characters only" }
  validates :product_id, presence: true
  validates :quantity, presence: { message: "must be provided" }, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :discount, numericality: { greater_than_or_equal_to: 0, message: "must be greater than or equal to 0" }
end
