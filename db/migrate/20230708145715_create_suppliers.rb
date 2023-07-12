class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :number
      t.string :address
      t.text :description

      t.timestamps
    end
  end
end
