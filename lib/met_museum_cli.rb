# application environment 

require 'bundler/setup'
Bundler.require(:default)

require_relative './met_museum_cli/cli.rb'
require_relative './met_museum_cli/api.rb'
require_relative './met_museum_cli/museum.rb'