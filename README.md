# Rtelldus

Ruby Framework for accessing the Telldus Live! API.

## Installation

Add this line to your application's Gemfile:

    gem 'rtelldus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rtelldus

## Usage

Generate your Telldus public and private keys at [api.telldus.com](http://api.telldus.com/keys/index)

Use Rtelldus.authorize to authenticate and get an access_token. The first time you run you will have to follow the onscreen instructions to properly authenticate using OAuth, the public and private keys will be saved together with the access token and access secret in ~/.rtelldus

Authorize will be run automatically on each call if not manually run before, so you can simply just run the calls if you'd like.

### Example usage:

    require "rtelldus"

    # Authorize
    Rtelldus.authorize

    # List all registered devices:
    Rtelldus.devices_list

    # Get the ID for the first listed device:
    Rtelldus.devices_list["device"].first["id"]

    # Turn on device:
    Rtelldus.device_turn_on "330108"

    # Turn off device:
    Rtelldus.device_turn_off "330108"

    # Dim a device (value between 0 and 255)L
    Rtelldus.device_dim "330108", 0

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
