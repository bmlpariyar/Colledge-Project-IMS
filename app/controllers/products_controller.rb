class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
    product = Product.find(params[:id])
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    cost_price = params["product"]["cost_price"].to_i
    selling_price = params["product"]["selling_price"].to_i
    respond_to do |format|
      if cost_price < selling_price
        if @product.save
          format.html { redirect_to product_url(@product), flash: { message: "Product created successfully", type: "success"} }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to new_product_path, flash: { message: "Selling price can't be less than cost price", type: "error" } }
      format.json { head :no_content }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def getProduct
    product = Product.find(params[:product_id])
    cost_price = product.cost_price
    selling_price = product.selling_price
    render json: { id: product.id,cost_price: cost_price, selling_price: selling_price }
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:supplier_id, :name, :cost_price, :selling_price)
    end
end
