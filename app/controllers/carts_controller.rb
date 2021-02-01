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

  def pay_with_paypal
    order = Order.find(params[:cart][:order_id])
    redirect_to order.pay_with_paypal(request.remote_ip, process_paypal_payment_cart_url, root_url)
  end

  def process_paypal_payment
    payment = Payment.find_by(token: params[:token])
    success = payment.process_paypal_payment(request.remote_ip)

    respond_to do |format|
      if success
        format.html { redirect_to root_url, notice: 'Payment successful.' }
      else
        format.html { redirect_to root_url, alarm: 'Error while processing payment.' }
      end
    end
  end
  
end
