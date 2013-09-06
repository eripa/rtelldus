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

Rename config-template.yaml to config.yaml and add your Telldus keys (can be generated at [api.telldus.com](http://api.telldus.com/keys/index))

Use Rtelldus.auth to authenticate and get an access_token. The first time you run you will have to follow the onscreen instructions to properly authenticate using OAuth, the access_token and access_secret will then be saved in ~/.rtelldus

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
