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
      product_data = Product.group(:name).count
      sale_data = Sale.joins(:product).group('products.name').group_by_day_of_week('sales.created_at', format: "%a").select('products.name, COUNT(*) as count, MAX(sales.created_at) as created_at').order('count DESC')
      sale_data = sale_data.map { |entry| [entry.name, entry.count, Date.parse(entry.created_at.strftime('%Y-%m-%d')).wday] }

  
      line_chart_data = []
      purchase_data.each do |product_date, count|
      product, date = product_date
      line_chart_data << { name: product, data: { date.to_date => count } }
      byebug
      end

    chart_data = {
      user_counts_by_day: user_data,
      purchase_counts_by_day: line_chart_data,
      product_counts_by_day: product_data,
      sale_counts_by_day_of_week: sale_data
    }

    render json: chart_data
  end


end
