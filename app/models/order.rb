class Order < ApplicationRecord
  before_create -> { generate_order_number(number_length) }

  belongs_to :user
  validates :number, uniqueness: true

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
