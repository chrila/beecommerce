require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'should list all its parent categories' do
    c1 = Category.create(name: 'Computer accessories')
    c2 = Category.create(name: 'Add-on cards', parent: c1)
    c3 = Category.create(name: 'Input devices', parent: c1)
    c4 = Category.create(name: 'Mouse', parent: c3)

    expect(c4.all_parents.size).to be == 2
  end

  it 'should list all its child categories' do
    c1 = Category.create(name: 'Computer accessories')
    c2 = Category.create(name: 'Add-on cards', parent: c1)
    c3 = Category.create(name: 'Graphics cards', parent: c2)
    c4 = Category.create(name: 'Input devices', parent: c1)
    c5 = Category.create(name: 'Mouse', parent: c4)
    c6 = Category.create(name: 'CPUs', parent: c1)
    c7 = Category.create(name: 'Intel', parent: c6)

    expect(c1.all_children.size).to be == 6
  end
end
