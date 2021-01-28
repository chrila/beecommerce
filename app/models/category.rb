class Category < ApplicationRecord
  has_and_belongs_to_many :products
  belongs_to :parent, class_name: "Category", foreign_key: "category_id", optional: true
  has_many :children, class_name: "Category"

  validates :name, presence: true, uniqueness: true

  def all_parents
    find_parents(self)
  end

  def all_children
    find_children
  end

  private

  def find_parents(category, parent_list=[])
    if category.parent
      parent_list << category.parent
      return find_parents(category.parent, parent_list)
    else
      return parent_list
    end
  end

  def find_children
    children_list = []
    current_children = self.children.to_a
    i = 0
    c = current_children[i]
    
    while c do
      current_children += c.children
      children_list << c
      i += 1
      c = current_children[i]
    end

    children_list
  end

end
