class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:products]

  # GET /suppliers or /suppliers.json
  def index
    @suppliers = Supplier.all
  end

  # GET /suppliers/1 or /suppliers/1.json
  def show
  end

  # GET /suppliers/new
  def new
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
  end

  # POST /suppliers or /suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)
  
    respond_to do |format|
      if @supplier.valid?
        if Supplier.exists?(name: @supplier.name) && Supplier.exists?(number: @supplier.number)
          format.html { redirect_to new_supplier_path, flash: { message: "Supplier with the same name or number already exists.", type: "error" } }
          format.json { render json: @supplier.errors, status: :unprocessable_entity }
        else
          if @supplier.save
            format.html { redirect_to supplier_url(@supplier), flash: { message: "Supplier was successfully created.", type: "success" } }
            format.json { render :show, status: :created, location: @supplier }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @supplier.errors, status: :unprocessable_entity }
          end
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /suppliers/1 or /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to supplier_url(@supplier), notice: "Supplier was successfully updated." }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1 or /suppliers/1.json
  def destroy
    @supplier.destroy

    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: "Supplier was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def products
    supplier = Supplier.find(params[:supplier_id])
    products = supplier.products
    render json: products, only: [:id, :name]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supplier_params
      params.require(:supplier).permit(:name, :number, :address, :description)
    end
end
