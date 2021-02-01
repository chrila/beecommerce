require 'faker'

Product.destroy_all

v_size = Variant.find_by(name: 'Size')
v_color = Variant.find_by(name: 'Color')

Category.all.each do |cat|
  10.times do
    product_name = Faker::Commerce.product_name
    product_desc = Faker::Hipster.sentence
    product_sku = Faker::Alphanumeric.alphanumeric(number: 10).upcase
    product_price = rand(10..100) * 990
    
    rand(1..5).times do
      p = Product.create(
        name: product_name,
        description: product_desc,
        stock: rand(10..50),
        price: product_price,
        sku: product_sku
      )
      p.categories << cat
      p.product_variants << ProductVariant.create(variant: v_color, value: Faker::Color.color_name)
      p.product_variants << ProductVariant.create(variant: v_size, value: rand(40..60))
    end
  end
end
