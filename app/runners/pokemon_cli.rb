class PokemonCli
  attr_accessor :player_1, :player_2
  def prompt_user(number)
    puts "PLAYER #{number} choose a character."
    puts "Type 'characters' to see a list of characters."
    puts "If you'd like a character not listed choose at your own risk."
    puts "Type 'help' at anytime to see game options."
    spacer
    gets.chomp.strip.downcase
  end

  def prompt_attack(attacker)
    puts "#{attacker.name.upcase} choose an attack.                                                     "
    puts "Type 'moves' to see a list of moves."
    puts "Type 'health' for hp values"
    spacer
    gets.chomp.strip.downcase
  end

  def switch_user
    @player_1, @player_2 = @player_2, @player_1
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type 'characters' to view the list of characters"
    spacer
  end

  def attack_help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    puts "Type 'moves' to view a list of moves"
    puts "Type 'health' to view health stats."

  end

  def player_pick(number)
    character = nil
    begin
      loop do
        choice = prompt_user(number)
        case choice
        when "characters"
          Character::CHARACTERS.each { |name| puts name }
        when "help"
          help
        when "exit"
          abort
        when "quit"
          abort
        else
          character = PokemonApi.pick_character(choice)
          break
        end
      end
      rescue
        puts "Please choose a REAL pokemon"

      retry
    end

    character
  end

  def player_attack(attacker, defender)
    character = nil

    loop do
      choice = prompt_attack(attacker)

      case choice
      when "moves"
        attacker.attacks
        spacer
      when "help"
        move_up
        attack_help
        spacer
      when "health"
        spacer
        puts "#{attacker.name.upcase} health: #{attacker.health}"
        puts "#{defender.name.upcase} health: #{defender.health}"
        spacer
      when "exit"
        abort
      when "quit"
        abort
      else
        attacker.attack(defender, choice)
        puts "#{attacker.name.upcase} health: #{attacker.health}"
        puts "#{defender.name.upcase} health: #{defender.health}"
        spacer
        break
      end
    end
    character
  end

  def welcome
    system ('clear')
    print_logo
  end

  def spacer
    puts "\n"
  end

  def print_logo
    puts "                 -------------PokeBattle-------------\n"
    puts "                      ;-.               ,  "
    puts "                      \\ '.           .'/    "
    puts "                       \\  \\ .---. .-' /     "
    puts "                        '. '     `\\_.'     "
    puts "                          |(),()  |     ,   "
    puts "                          (  __   /   .' \\  "
    puts "                         .''.___.'--,/\\_,|  "
    puts "                        {  /     \\   }   |  "
    puts "                         '.\\     /_.'    /  "
    puts "                          |'-.-',  `; _.'   "
    puts "                          |  |  |   |`     "
    puts "                          `\"\"`\"\"`\"\"\"\"` "
  end

  def winner?
    player_1.health <= 0 || player_2.health <= 0
  end

  def display_winner
   if player_1.health > 0
     puts "#{player_1.name.upcase} you are victorious!\n"
   else
     puts "#{player_2.name.upcase} you are victorious!\n"
   end
  end

  def play_turn
    until winner?
      player_attack(player_1, player_2)
      switch_user
    end
  end

  def clear
    system ('clear')
    print_logo
  end

  def play_battle
    system ('clear')
    puts "--------------  FIGHT! --------------"
    spacer
  end

  def play
    welcome

    @player_1 = player_pick(1)
    clear
    @player_2 = player_pick(2)
    clear

    play_battle
    play_turn

    display_winner
  end

end
