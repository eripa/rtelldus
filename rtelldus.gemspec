# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rtelldus/version'

Gem::Specification.new do |spec|
  spec.name          = "rtelldus"
  spec.version       = Rtelldus::VERSION
  spec.authors       = ["Eric Ripa"]
  spec.email         = ["eric@ripa.io"]
  spec.description   = %q{Ruby Framework for Telldus Live! API}
  spec.summary       = %q{Ruby Framework for Telldus Live!}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "oauth"
  spec.add_dependency "json"
  spec.add_dependency "user_config"
end
