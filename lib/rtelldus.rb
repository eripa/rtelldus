require "rtelldus/version"
require 'oauth'
require 'json'
require 'yaml'
require 'user_config'


module Rtelldus
  @config = YAML.load_file 'lib/config.yaml'
  @uconf = UserConfig.new(".rtelldus")
  def self.authorize
    oauth_options = @config['telldus-api']
    consumer_options = { :site => oauth_options['api_host'],
                         :authorize_path => oauth_options['authorize_path'],
                         :request_token_path => oauth_options['request_token_path'],
                         :access_token_path => oauth_options['access_token_path'] }
    consumer = OAuth::Consumer.new(oauth_options['consumer_key'], oauth_options['consumer_secret'], consumer_options)

    if File.exists? @uconf["api_token.yaml"].path
      @access_token = OAuth::AccessToken.new(consumer, @uconf["api_token.yaml"]["access_token"], @uconf["api_token.yaml"]["access_secret"])
    else
      # No configuration exists, let's request  some access tokens
      # Fetch a new access token and secret from the command line
      request_token = consumer.get_request_token
      puts "Copy and paste the following URL in your browser:"
      puts "\t#{request_token.authorize_url}"
      puts "When you sign in and accept, press enter.."
      verifier = $stdin.gets.strip
      access_token = request_token.get_access_token(:oauth_verifier => verifier)
      # Save the token and secret so the script can be used automatically in the future
      @uconf["api_token.yaml"]["access_token"] = access_token.token
      @uconf["api_token.yaml"]["access_secret"] = access_token.secret
      @uconf["api_token.yaml"].save
      @access_token = OAuth::AccessToken.new(consumer, @uconf["api_token.yaml"]["access_token"], @uconf["api_token.yaml"]["access_secret"])
    end
  end

  def self.clients_list
    authorize unless @access_token
    json_txt = @access_token.post("/json/clients/list", 'x-li-format' => 'json').body
    clients = JSON.parse(json_txt)
  end

  def self.devices_list
    authorize unless @access_token
    json_txt = @access_token.get("/json/devices/list", 'x-li-format' => 'json').body
    devices = JSON.parse(json_txt)
  end

  def self.device_turn_off device_id
    authorize unless @access_token
    json_txt = @access_token.post("/json/device/turnOff", {"id" => device_id}, 'x-li-format' => 'json').body
    status = JSON.parse(json_txt)
  end

  def self.device_turn_on device_id
    authorize unless @access_token
    json_txt = @access_token.post("/json/device/turnOn", {"id" => device_id}, 'x-li-format' => 'json').body
    status = JSON.parse(json_txt)
  end
end
