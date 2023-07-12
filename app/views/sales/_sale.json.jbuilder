json.extract! sale, :id, :bill_no, :customer_name, :product_id, :quantity, :total, :discount, :taxable_amount, :vat, :net_total, :description, :created_at, :updated_at
json.url sale_url(sale, format: :json)
