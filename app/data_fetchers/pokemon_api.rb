class PokemonApi

  def self.get_character(user_choice)
    url = "http://pokeapi.co/api/v2/pokemon/?limit=1000"

    response = RestClient.get(url)
    result = JSON.parse(response)["results"]

    result.find { |character| character["name"] == user_choice }
  end

  def self.create_character(character_hash)
    moves = []

    response = RestClient.get(character_hash["url"])
    result = JSON.parse(response)

    name = result["name"]
    base_experience = result["base_experience"]
    result["moves"].each do |hash|
      moves << hash["move"]["name"]
    end

    Character.new(name, base_experience, moves)
  end

  def self.pick_character(user_choice)
    character_hash = get_character(user_choice)
    create_character(character_hash)
  end

end
