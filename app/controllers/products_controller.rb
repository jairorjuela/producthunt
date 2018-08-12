class ProductsController < ApplicationController

  before_action :private_acces, except: [:index, :show]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to products_path, notice: "El producto fue publicado con exito"
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
      redirect_to products_path, notice: "El producto ha sido modificado con exito"
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_path, notice: "El producto fue eliminado con exito"
  end

  private
    def product_params
      params.require(:product).permit(:name, :url, :description)
    end
end
