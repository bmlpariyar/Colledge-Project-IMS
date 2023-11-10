ActiveRecord::Schema[7.0].define(version: 2023_07_16_145845) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.bigint "supplier_id", null: false
    t.string "name"
    t.decimal "cost_price"
    t.decimal "selling_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "bill_no"
    t.bigint "supplier_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.decimal "total"
    t.decimal "discount"
    t.decimal "taxable_amount"
    t.decimal "vat"
    t.decimal "net_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.date "date"
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["supplier_id"], name: "index_purchases_on_supplier_id"
  end

  create_table "sales", force: :cascade do |t|
    t.string "bill_no"
    t.string "customer_name"
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.decimal "total"
    t.decimal "discount"
    t.decimal "taxable_amount"
    t.decimal "vat"
    t.decimal "net_total"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["product_id"], name: "index_sales_on_product_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.string "address"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "products", "suppliers"
  add_foreign_key "purchases", "products"
  add_foreign_key "purchases", "suppliers"
  add_foreign_key "sales", "products"
end
