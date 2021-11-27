class Menu
  attr_accessor :option

  def print_menu()
    puts <<~MENU
    ------------------Menu--------------------------
    [1] Cadastrar um item para estuda  
    [2] Ver todos os itens cadastrados
    [3] Buscar um item de estudo
    [4] Marcar um item como concluido
    [5] Sair
    ------------------------------------------------
   MENU
  
  end

  def print_menu_and_get_option()
    print_menu()
    read_option()
  end

  def read_option()
    puts 'Escolha uma opção: '
    @option = gets.to_i
    @option
  end 
end