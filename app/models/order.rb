class Order < ApplicationRecord
  before_validation -> { generate_order_number(number_length) }

  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  has_many :payments
  belongs_to :coupon, optional: true
  
  validates :number, uniqueness: true

  def add_product(product, quantity)
    if product && product.stock.positive?
      OrderItem.create(product: product, order: self, quantity: quantity, price: product.price)
      self.total += product.price * quantity.to_i
      self.save!
    end
  end

  def pay_with_paypal(remote_ip, return_url, cancel_return_url)
    #price must be in cents
    price = total * 100

    response = EXPRESS_GATEWAY.setup_purchase(price,
      ip: remote_ip,
      return_url: return_url,
      cancel_return_url: cancel_return_url,
      allow_guest_checkout: true,
      currency: "USD"
    )

    payment_method = PaymentMethod.find_by(code: "PEC")
    Payment.create(
      order_id: self.id,
      payment_method_id: payment_method.id,
      state: "processing",
      total: self.total,
      token: response.token
    )

    EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  private

  def number_length
    9
  end

  def number_prefix
    'BO'
  end

  def random_number_candidate(length)
    "#{number_prefix}#{Array.new(length){rand(length)}.join}"
  end

  def generate_order_number(length)
    self.number ||= loop do
      random = random_number_candidate(length)
      break random unless Order.exists?(number: random)
    end  
  end

end
