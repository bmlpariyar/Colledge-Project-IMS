class Purchase < ApplicationRecord
  belongs_to :supplier
  belongs_to :product


  validate :positive_bill_no
  validate :positive_quantity
  validate :positive_discount
  validate :date_present

  private

  def positive_bill_no
    if bill_no.present? && bill_no <= "0"
      errors.add(:bill_no, "must be a positive number")
    end
  end

  def date_present
    if !date.present?
      errors.add(:date, "Please select a date")
    end
    
  end

  def positive_quantity
    if quantity.present? && quantity <= 0
      errors.add(:quantity, "must be a positive number")
    end
  end

  def positive_discount
    if discount.present? && discount < 0
      errors.add(:discount, "must be a positive number")
    end
  end
end