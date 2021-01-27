class CartsController < ApplicationController
  before_action :authenticate_user!

  def update
    product = Product.find(params[:cart][:product_id])
    quantity = params[:cart][:quantity]

    current_order.add_product(product, quantity)

    redirect_to root_url, notice: 'Product added successfully'
  end

  def show
    @order = current_order
  end
end
