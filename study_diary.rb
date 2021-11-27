require 'io/console'
require_relative 'category'
require_relative 'menu'
require_relative 'item'

$itemList = []

def welcome()
   puts 'Bem-vindo ao Diário de estudos. 
   Vamos começar!!'
end

def find_category_by_id(id)
  aux = nil

  Category.get_default_list().each{ | category | 
    if category.id == id  
      aux = category
      break
     end
    }
    aux
  end
  
  def list_category()
    puts "Agora escolha a categoria:"
    Category.get_default_list().each{ | category |
    puts "#{category.id } #{category.description}"
  }
end

def get_all()
  $itemList
end

def list_items()
        get_all().each.with_index(1) { |item,index|
          puts "##{index} - #{item.title } - #{item.category.description} #{ 'Finalizada!' if item.done}"
        }
        puts 'Nenhum item cadastrado' if get_all().empty?
  
  wait_keypress()
end


def finalized_list()
  not_finalized_list = get_all().filter { | item | !item.done }
  get_all().each.with_index(1) do |item,index| 
    puts "##{index} - #{item.title } - #{item.category.description} #{'Finalizada!' if item.done}"
  end
  
  if not_finalized_list.empty?
    puts 'Nenhum item encontrado'
  else
    print 'Digite o item que deseja finalizar: '
    index = gets.to_i
    not_finalized_list[index -1].done = true
  end
  
  
  wait_keypress()
 
 end

def wait_keypress
  puts "Pressione qualquer tecla para continuar"
  STDIN.getch
end

def find_by_title()
  puts "Digite o texto para procura:"
  text = gets.chomp()

  results = get_all().filter do |item |
    item.title.downcase.include? text.downcase
  end

  puts "Foram encontrados #{results.length} \n "
  
  results.each { |e|
    puts " - #{ e.title } #{e.category.description}"
   }

  puts 'Nenhum item encontrado' if results.empty?
  
    wait_keypress()

end


def writeFile(item)
  open("arquivo.txt", "a") { |f| 
    f << "#{item.title} #{item.category.description} #{item.created_at}\n"
  }
end

def run_app()
  menu = Menu.new()

  option = 0
  while option != 5 do
    option = menu.print_menu_and_get_option()
  
    case option.to_i
    when 1
        item = Item.new().create_item()
        $itemList << item 
        writeFile(item)  
    when 2
      list_items()
    when 3
      find_by_title()
    when 4
      finalized_list()
    when 5
      option = 5
    else 
      option = menu.print_menu_and_get_option()
    end
  
    puts "\e[H\e[2J" #limpa terminal
  end
  
  puts "programa finalizado" 
end
puts "\e[H\e[2J" #limpa terminal
welcome()
run_app()


