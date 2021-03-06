class Character

  CHARACTERS = [
    "mew",
    "charmander",
    "pikachu-pop-star",
    "charizard",
    "jigglypuff",
    "gengar",
    "arcanine",
    "pikachu",
    "lucario",
    "bulbasaur"
  ]

  EXCLAMATIONS = ["BAM","BOOM", "WHAM", "KA-POW", "SLASH"]

  attr_accessor :health
  attr_reader :moves, :name, :base_experience

  def initialize(name, base_experience, moves)
    @name = name
    @base_experience = base_experience
    @moves = moves
    @health = 100
  end

  def attack(defender, attack)
    system ('clear')
    defender.health -= attack_value(attack)
    spacer
  end

  # def attack_value(attack)
  #   av = moves.index(attack)
  #   bv = (base_experience / 50)
  #   puts "Attack value: #{av}, Base value: #{bv}"
  #   bv + av
  # end

  def attack_value(attack)
    unless moves.include?(attack)
      puts "--------------    Next Move    --------------\n"
      puts "Lern to spell.  You just lost your turn and 5 hp :)"
      self.health -= 5
      0
    else
      av = [*1..50].sample + (base_experience / 20)
      puts "--------------    Next Move    --------------\n"
      puts "#{EXCLAMATIONS.sample} you just got --#{attack}ed-- for #{av} hp"
      av
    end
  end

  def spacer
    puts "\n"
  end

  def attacks
    last_move = moves.pop
    moves.each { |move| print "#{move}, " }
    print "#{last_move}. \n"
    moves << last_move
  end
end
