json.extract! product, :id, :supplier_id, :name, :cost_price, :selling_price, :created_at, :updated_at
json.url product_url(product, format: :json)
