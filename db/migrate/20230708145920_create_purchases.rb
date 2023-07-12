class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.string :bill_no
      t.references :supplier, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :total
      t.decimal :discount
      t.decimal :taxable_amount
      t.decimal :vat
      t.decimal :net_total

      t.timestamps
    end
  end
end
