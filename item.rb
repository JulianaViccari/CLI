require_relative 'category'

class Item
  attr_accessor :description, :category, :createdAt
  
  def initialize(description, category)
    @description = description
    @category = category
    @createdAt = Time.now.to_s
  end
end