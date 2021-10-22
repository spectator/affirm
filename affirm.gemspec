# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'affirm/version'

Gem::Specification.new do |spec|
  spec.name          = "affirm-ruby"
  spec.version       = Affirm::VERSION
  spec.authors       = ["Yury Velikanau", "Igor Pstyga"]
  spec.email         = ["yury.velikanau@gmail.com"]
  spec.summary       = %q{Ruby wrapper for Affirm.com API}
  spec.description   = %q{Ruby client library for Affirm.com API}
  spec.homepage      = "https://github.com/spectator/affirm"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = [">= 2.1", "< 4.0"]
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "virtus", "~> 1.0", ">= 1.0.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "byebug"
end
