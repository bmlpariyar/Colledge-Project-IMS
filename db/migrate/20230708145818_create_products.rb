class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :supplier, null: false, foreign_key: true
      t.string :name
      t.decimal :cost_price
      t.decimal :selling_price

      t.timestamps
    end
  end
end
