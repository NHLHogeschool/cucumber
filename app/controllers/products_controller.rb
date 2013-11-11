class ProductsController < ApplicationController
  def index
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    render text: @product.title
  end

  private

  def product_params
    params.require(:product).permit(:title, :details)
  end
end
