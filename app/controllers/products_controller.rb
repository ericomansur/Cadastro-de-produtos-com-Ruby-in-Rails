class ProductsController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :set_product, only: %i[show update destroy]

  def index
    @products = Product.all

    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def show
    render json: @product
  end

  def new
    @product = Product.new
  end


  def create
    @product = Product.new(product_params)

    if @product.save
      respond_to do |format|
        format.html { redirect_to products_path, notice: "Produto criado com sucesso" }
        format.json { render json: @product, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description)
  end
end
