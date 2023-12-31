class SalesController < ApplicationController
  before_action :set_sale, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /sales or /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1 or /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @products = Product.all
    @sale = Sale.new

  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales or /sales.json
  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to new_sale_path, notice: "Sale was successfully created."  }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html do
          @products = Product.all
          render :new, status: :unprocessable_entity
          end
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end 
    end 
  end 



  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to sale_url(@sale), notice: "Sale was successfully updated." }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to sales_url, notice: "Sale was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  
  def stock_report
    @report_data = ActiveRecord::Base.connection.execute("SELECT(SELECT name FROM products pr WHERE pr.id = p.product_id) AS product_name, p.quantity AS purchase_quantity, s.quantity AS sale_quantity, CASE WHEN (p.quantity - COALESCE(s.quantity, 0)) < 0 THEN 0 ELSE (p.quantity - COALESCE(s.quantity, 0)) END AS remaining_stock FROM purchases p LEFT JOIN sales s ON p.product_id = s.product_id WHERE s.quantity IS NOT NULL")
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      params.require(:sale).permit(:bill_no, :date, :customer_name, :product_id, :quantity, :total, :discount, :taxable_amount, :vat, :net_total, :description)
    end
end
