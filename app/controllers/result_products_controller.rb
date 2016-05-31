class ResultProductsController < ApplicationController
  before_action :set_result_product, only: [:show, :edit, :update, :destroy]

  # GET /result_products
  # GET /result_products.json
  def index
    @result_products = ResultProduct.all
  end

  # GET /result_products/1
  # GET /result_products/1.json
  def show
  end

  # GET /result_products/new
  def new
    @result_product = ResultProduct.new
  end

  # GET /result_products/1/edit
  def edit
  end

  # POST /result_products
  # POST /result_products.json
  def create
    @result_product = ResultProduct.new(result_product_params)

    respond_to do |format|
      if @result_product.save
        format.html { redirect_to @result_product, notice: 'Result product was successfully created.' }
        format.json { render :show, status: :created, location: @result_product }
      else
        format.html { render :new }
        format.json { render json: @result_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /result_products/1
  # PATCH/PUT /result_products/1.json
  def update
    respond_to do |format|
      if @result_product.update(result_product_params)
        format.html { redirect_to @result_product, notice: 'Result product was successfully updated.' }
        format.json { render :show, status: :ok, location: @result_product }
      else
        format.html { render :edit }
        format.json { render json: @result_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /result_products/1
  # DELETE /result_products/1.json
  def destroy
    @result_product.destroy
    respond_to do |format|
      format.html { redirect_to result_products_url, notice: 'Result product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result_product
      @result_product = ResultProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_product_params
      params.require(:result_product).permit(:name, :nick_seller, :price, :url, :sold, :description_html, :type)
    end
end
