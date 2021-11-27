require 'sqlite3'
require_relative 'category'

class Item
  attr_accessor :title, :category, :created_at, :done
  
  def create_item()
    puts "Digite o titulo de seu item de estudo:"
    title = gets.chomp()
  
    list_category()
    categoryOp = gets.chomp()
    
    category = find_category_by_id(categoryOp.to_i)
    item = Item.new()
    item.title = title
    item.category = category

    save_into_db(item)
    item
  end

  def save_into_db(item)
    db = SQLite3::Database.open 'db/database.db'
    puts db.to_s
    db.execute(<<~SQL, item.title, item.category.description, 0)
      INSERT INTO study_items (title, category, done)
      VALUES (?, ?, ? )
      SQL
    ensure
      db.close if db
  end
  
end