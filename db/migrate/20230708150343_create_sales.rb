class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.string :bill_no
      t.string :customer_name
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :total
      t.decimal :discount
      t.decimal :taxable_amount
      t.decimal :vat
      t.decimal :net_total
      t.text :description

      t.timestamps
    end
  end
end
