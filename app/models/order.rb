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
    end
  end

  def total
    order_items.map(&:price).sum
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
