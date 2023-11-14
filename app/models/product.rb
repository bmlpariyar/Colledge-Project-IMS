class Product < ApplicationRecord
  belongs_to :supplier
  has_many :purchases
  validates :name, uniqueness: { scope: :supplier_id, message: "Product already exists for the same supplier" }

end