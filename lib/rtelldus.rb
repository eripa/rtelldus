require "rtelldus/version"
require 'oauth'
require 'json'
require 'yaml'

module Rtelldus
  config = YAML.load('config.yaml')

  oauth_options = config['telldus-api']

  # Set up LinkedIn specific OAuth API endpoints

  consumer = OAuth::Consumer.new(oauth_options['consumer_key'], oauth_options['consumer_secret'], consumer_options)
end
