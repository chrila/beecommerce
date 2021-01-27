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
end
