class Supplier < ApplicationRecord
  has_many :products
  has_many :purchases

  validates :name, presence: true, length: { maximum: 100 }, format: { with: /\A[a-zA-Z\s]+\z/, message: "should only contain letters" }

  validates :number, presence: true, length: { maximum: 20 }, format: { with: /\A(98\d{8}|011\d{6})\z/, message: "should be in the format 98xxxxxxxx or 011xxxxxx",} ,numericality: { only_integer: true }

  validates :address, presence: true, length: { maximum: 200 }
end