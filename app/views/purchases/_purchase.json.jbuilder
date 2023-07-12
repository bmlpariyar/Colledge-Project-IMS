json.extract! purchase, :id, :bill_no, :supplier_id, :product_id, :quantity, :total, :discount, :taxable_amount, :vat, :net_total, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
