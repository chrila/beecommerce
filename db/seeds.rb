# load individual files in given order
load File.join(Rails.root, 'db', 'seeds', 'categories.rb')
load File.join(Rails.root, 'db', 'seeds', 'variants.rb')
load File.join(Rails.root, 'db', 'seeds', 'products.rb')
load File.join(Rails.root, 'db', 'seeds', 'payment_methods.rb')
