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
    supplier_data = Supplier.group_by_day(:created_at).count
    product_data = Product.group_by_day(:created_at).count
    sale_data = Sale.group_by_day_of_week(:created_at, format: "%a").count

    chart_data = {
      user_counts_by_day: user_data,
      supplier_counts_by_day: supplier_data,
      product_counts_by_day: product_data,
      sale_counts_by_day_of_week: sale_data
    }

    render json: chart_data
  end


end
