puts  "Bem-vindo ao Diário de estudos. Vamos começar!!\n"

def menu()
  puts  "[1] Cadastrar um item para estudar"
  puts  "[2] Ver todos os itens cadastrados"
  puts  "[3] Buscar um item de estudo"
  puts  "[4] Sair"
  puts "Escolha uma opção:"
  option = gets.chomp()
  option
end

def qualquerTecla()
  puts "Pressione qualquer tecla para continuar"

  gets.chomp()
end

class Category
  attr_accessor :id, :description
  
  def initialize(id, description)
    @id = id
    @description = description
  end
end

class Item
  attr_accessor :description, :category

  def initialize(description, category)
  @description = description
  @category = category
  end
end

ruby = Category.new(1, "Ruby")
rails = Category.new(2, "Rails")
html = Category.new(3, "HTML")

$catList = [ruby, rails, html]
$itemList = []

def findCategoryById(id)
  aux = nil

  $catList.each{ | category | 
     if category.id == id  
      aux = category
      break
     end
  }
  aux
end

def listCategory()
  $catList.each{ | category |
    puts "##{category.id } #{category.description}"
  }
end

def listItems()
  $itemList.each{ | item |
    puts "#{item.description } #{item.category.description}"
  }

  qualquerTecla()
end


def createItem()
  puts "Digite o titulo de seu item de estudo:"
  description = gets.chomp()

  listCategory()
  puts "Escolha a categoria:"
  categoryOp = gets.chomp()
  
  category = findCategoryById(categoryOp.to_i)
  Item.new(description, category)
end

def findByDescription()
  puts "Digite o texto:"
  text = gets.chomp()

  result = []

  $itemList.each{ |item|
    if  item.description.downcase.include? text.downcase
      result << item
    end
  }

  puts "Foram encontrados #{result.length}\n"
  
  result.each{ | item | 
    puts "#{item.description} #{item.category.description}"
  }

  puts "Pressione qualquer tecla para continuar"
  gets.chomp()
end



opcao = 0
while opcao != 4 do
  opcao = menu()

  case opcao.to_i
  when 1
      item = createItem()
      $itemList << item 
  when 2
    listItems()
  when 3
    findByDescription()
  when 4
    opcao = 4
  else 
    menu()
  end

  puts "\e[H\e[2J" #limpa terminal
         
end

puts "programa finalizado" 

