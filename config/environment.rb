require 'Bundler'
Bundler.require
$: << "."

# require_relative '../app/models/character'
# require_relative '../app/data_fetchers/pokemon_api'
# require_relative '../app/runners/pokemon_cli'

Dir["app/*/*.rb"].each { |f| require f }
