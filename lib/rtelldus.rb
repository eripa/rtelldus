require "rtelldus/version"
require 'oauth'
require 'json'
require 'yaml'
require 'user_config'


module Rtelldus
  @config = YAML.load_file 'lib/config.yaml'
  @uconf = UserConfig.new(".rtelldus")
  def self.auth
    oauth_options = @config['telldus-api']
    consumer_options = { :site => oauth_options['api_host'],
                         :authorize_path => oauth_options['authorize_path'],
                         :request_token_path => oauth_options['request_token_path'],
                         :access_token_path => oauth_options['access_token_path'] }
    consumer = OAuth::Consumer.new(oauth_options['consumer_key'], oauth_options['consumer_secret'], consumer_options)


    if File.exists? @uconf["api_token.yaml"].path
      OAuth::AccessToken.new(consumer, @uconf["api_token.yaml"]["access_token"], @uconf["api_token.yaml"]["access_secret"])
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
      OAuth::AccessToken.new(consumer, @uconf["api_token.yaml"]["access_token"], @uconf["api_token.yaml"]["access_secret"])
    end
  end

  def self.get_devices access_token
    json_txt = access_token.get("/json/devices/list", 'x-li-format' => 'json').body
    devices = JSON.parse(json_txt)
    devices["device"]
  end

  def self.turn_off access_token, device_id
    json_txt = access_token.post("/json/device/command", {"id" => device_id, "value" => 0, "method" => 2}, 'x-li-format' => 'json').body
    status = JSON.parse(json_txt)
  end

  def self.turn_on access_token, device_id
    json_txt = access_token.post("/json/device/command", {"id" => device_id, "value" => 0, "method" => 1}, 'x-li-format' => 'json').body
    status = JSON.parse(json_txt)
  end
end
