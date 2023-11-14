class Sale < ApplicationRecord
  belongs_to :product
  has_one :supplier, through: :product

  validates :bill_no, presence: true, numericality: { greater_than_or_equal_to: 0, message: "must be greater than 0" }
  validates :date, presence: true
  validates :customer_name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/, message: "must be alphabetical characters only" }
  validate :date_present
  validates :quantity, presence: { message: "must be provided" }, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :discount, numericality: { greater_than_or_equal_to: 0, message: "must be greater than or equal to 0" }

  private
  def date_present
    if !date.present?
      errors.add(:date, "Please select a date")
    elsif date.present? && date > Date.current
      errors.add(:date,"Please select a date on or before today")
    end
  end
end


