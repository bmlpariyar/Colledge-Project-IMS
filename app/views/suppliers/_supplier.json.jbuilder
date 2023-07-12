json.extract! supplier, :id, :name, :number, :address, :description, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)
