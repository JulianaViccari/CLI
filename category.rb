require_relative 'item'
 class Category
  attr_accessor :id, :description
  
  def initialize(id, description)
    @id = id
    @description = description
  end

  def self.get_default_list()
    ruby = Category.new(1, "Ruby")
    rails = Category.new(2, "Rails")
    html = Category.new(3, "HTML")
    defalt_list = [ruby, rails, html]
  end
end
