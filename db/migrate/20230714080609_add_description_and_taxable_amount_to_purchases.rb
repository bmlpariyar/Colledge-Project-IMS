class AddDescriptionAndTaxableAmountToPurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :description, :text
  end
end
