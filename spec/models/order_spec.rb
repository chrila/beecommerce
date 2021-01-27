require 'rails_helper'

RSpec.describe Order, type: :model do
  it 'generates a random order number upon creation' do
    user = User.create(email: 'test@test.com', password: 'asdfghjkl')
    order = Order.create(user: user)
    expect(order.number).to be_truthy
  end

  it 'is not allowed to have duplicate order numbers' do
    user = User.create(email: 'test@test.com', password: 'asdfghjkl')
    order = Order.create(user: user)
    order2 = order.dup
    expect(order2).to_not be_valid
  end

  it 'adds products as order_items' do
    user = User.create(email: 'test@test.com', password: 'asdfghjkl')
    order = Order.create(user: user)
    product = Product.create(name: 'TestItem', price: 1000, stock: 10, sku: 'ASDF001')
    
    order.add_product(product, 1)
    expect(order.order_items.count).to be == 1
  end

  it 'is not allowed to add a product without stock' do
    user = User.create(email: 'test@test.com', password: 'asdfghjkl')
    order = Order.create(user: user)
    product = Product.create(name: 'TestItem', price: 1000, stock: 0, sku: 'ASDF001')
    
    order.add_product(product, 1)
    expect(order.order_items.count).to be == 0
  end
end
