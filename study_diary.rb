require 'io/console'
require_relative 'category'
require_relative 'menu'
require_relative 'item'

puts <<~Heredock 
   Bem-vindo ao Diário de estudos. 
   Vamos começar!!
Heredock


def qualquerTecla()
  puts "Pressione qualquer tecla para continuar"
  
  gets.chomp()
end

$itemList = []

def findCategoryById(id)
  aux = nil

  Category.get_default_list().each{ | category | 
    if category.id == id  
      aux = category
      break
     end
    }
    aux
  end
  
  def listCategory()
    puts "Agora escolha a categoria:"
    Category.get_default_list().each{ | category |
    puts "#{category.id } #{category.description}"
  }
end

def listItems()

    if $itemList.length == 0
      puts 'Nenhum item cadastrado'
    else 
      $itemList.each{ | item |
        puts "#{item.description } #{item.category.description} "
        }
    end  
  
  qualquerTecla()
end

def findItems()
  if $itemList.length == 0
    puts 'Nenhum item encontrado'
  else
    $itemList.each { |item| 
    puts "#{item.description } #{item.category.description} Finalizada!"
    }
  end
  qualquerTecla()
end


def createItem()
  puts "Digite o titulo de seu item de estudo:"
  description = gets.chomp()

  
  listCategory()
  categoryOp = gets.chomp()
  
  category = findCategoryById(categoryOp.to_i)
  Item.new(description, category)
end

def wait_keypress
  puts
  puts "Pressione qualquer tecla para continuar"
  STDIN.getch
end

def findByDescription()
  puts "Digite o texto:"
  text = gets.chomp()

  result = []

  $itemList.each{ |item |
    if item.description.downcase.include? text.downcase
      result << item
    end
  }
  puts "Foram encontrados #{result.length}\n"
  
  result.each{ | item | 
    puts "#{item.description} #{item.category.description}"

  }
    wait_keypress()

end


def writeFile(item)
  open("arquivo.txt", "a") { |f| 
    f << "#{item.description} #{item.category.description} #{item.createdAt}\n"
  }
end

def print_menu_and_get_option()
  menu = Menu.new()
  menu.print_menu()
  menu.read_option()
end

option = 0
while option != 5 do
  option = print_menu_and_get_option()

  case option.to_i
  when 1
      item = createItem()
      $itemList << item 
      writeFile(item)  
  when 2
    listItems()
  when 3
    findByDescription()
  when 4
    findItems()
  when 5
    option = 5
  else 
    option = print_menu_and_get_option()
  end

  puts "\e[H\e[2J" #limpa terminal
         
end

puts "programa finalizado" 

