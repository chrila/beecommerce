require 'faker'

Category.destroy_all

10.times do
  Category.create(name: Faker::Commerce.department(max: 1))
end
