# app/controllers/ims_controller.rb

class ImsController < ApplicationController

  def main
    @supplier_data = Supplier.count
    @product_data = Product.count
    @customer_data = Sale.select(:customer_name).distinct.count
    @user_data = User.count

  end

  def chart_data
      user_data = User.group_by_day(:created_at).count
      purchase_data = Purchase.joins(:product).group('products.name', 'DATE(purchases.created_at)').count
      product_data = ActiveRecord::Base.connection.execute("SELECT s.\"name\", ARRAY_AGG(p.name) AS product_names, COUNT(*) AS product_count FROM products p left join suppliers s on p.supplier_id = s.id  GROUP BY s.\"name\"")
      pie_data = product_data.map do |data|
        product_names = data["product_names"].scan(/"([^"]*)"/).flatten
        {
          supplier_name: data["name"],
          product_names: product_names,
          product_count: data["product_count"]
        }
      end

      sale_data = Sale.joins(:product).group('products.name').group_by_day_of_week('sales.created_at', format: "%a").select('products.name, COUNT(*) as count, MAX(sales.created_at) as created_at').order('count DESC')
      sale_data = sale_data.map do |entry|
        name = entry.name
        count = entry.count
        created_at = entry.created_at
        next if name.nil? || count.nil? || created_at.nil?
        [name, count, Date.parse(created_at.strftime('%Y-%m-%d')).wday] 
      end

      
    line_chart_data = ActiveRecord::Base.connection.execute("SELECT p2.name AS name, jsonb_object_agg(date, purchase_count) AS data FROM ( SELECT p.product_id, p.date, COUNT(p.date) AS purchase_count FROM purchases p GROUP BY p.product_id, p.date ) AS subquery LEFT JOIN products p2 ON subquery.product_id = p2.id GROUP BY p2.name;")
    line_data =  line_chart_data.map{|pdata| {name: pdata["name"], data: pdata["data"]}}
    chart_data = {
      user_counts_by_day: user_data,
      purchase_counts_by_day: line_data,
      product_counts_by_day: pie_data,
      sale_counts_by_day_of_week: sale_data,
    }

    render json: chart_data
  end


end
