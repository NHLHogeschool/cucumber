class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json, :html

  def index
    @product = Product.new
    @products = Product.all

    respond_with @products
  end

  def create
    @product = Product.create(product_params)
    render text: @product.title
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    respond_with @product
  end

  private

  def product_params
    params.require(:product).permit(:title, :details)
  end
end
