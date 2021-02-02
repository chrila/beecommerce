require 'rails_helper'

RSpec.describe Payment, type: :model do
  it 'is able to process a paypal payment' do
    payment_method = PaymentMethod.create(name: 'PayPal Express Checkout', code: 'PEC')
    user = User.create(email: 'test@test.com', password: 'asdfghjkl')
    order = Order.create(user: user)
    product = Product.create(name: 'TestItem', price: 1000, stock: 10, sku: 'ASDF001')
    order.add_product(product, 5)
    url = order.pay_with_paypal('192.168.1.1', 'a', 'b')
    payment = order.payments.last
    payment.process_paypal_payment('192.168.1.1')
    expect(payment.state).to be == 'processing'
  end
end
