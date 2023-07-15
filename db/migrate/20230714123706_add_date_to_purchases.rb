class AddDateToPurchases < ActiveRecord::Migration[7.0]
  def change
    add_column :purchases, :date, :date
  end
end
