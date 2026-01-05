class ProductsController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :set_product, only: %i[show edit update destroy]


  def index
    @products = Product.all

    # Busca por nome
    if params[:search].present?
      @products = @products.where("name ILIKE ?", "%#{params[:search]}%")
    end

    # Ordenação
    case params[:sort]
    when "name_asc"
      @products = @products.order(name: :asc)
    when "name_desc"
      @products = @products.order(name: :desc)
    when "price_asc"
      @products = @products.order(price: :asc)
    when "price_desc"
      @products = @products.order(price: :desc)
    else
      @products = @products.order(created_at: :desc)
    end

    # Paginação (usando Kaminari)
    @products = @products.page(params[:page]).per(6)
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
      respond_to do |format|
        format.html { redirect_to products_path, notice: "Produto atualizado" }
        format.json { render json: @product }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end


  def edit
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_path, notice: "Produto excluído com sucesso" }
      format.json { head :no_content }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description)
  end



end
