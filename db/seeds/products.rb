require 'faker'

Product.destroy_all

Category.all.each do |cat|
  10.times do
    p = Product.create(
      name: Faker::Commerce.product_name,
      description: Faker::Hipster.sentence,
      stock: rand(10..50),
      price: rand(10..100) * 990,
      sku: Faker::Alphanumeric.alphanumeric(number: 10).upcase
    )
    p.categories << cat
  end
end
