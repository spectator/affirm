# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'affirm/version'

Gem::Specification.new do |spec|
  spec.name          = "affirm"
  spec.version       = Affirm::VERSION
  spec.authors       = ["Yury Velikanau"]
  spec.email         = ["yury.velikanau@gmail.com"]
  spec.summary       = %q{Ruby API wrapper for Affirm.com}
  spec.description   = %q{Ruby API wrapper for Affirm.com}
  spec.homepage      = "https://github.com/spectator/affirm"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = "~> 2.0"
  spec.add_dependency "faraday", "~> 0.9.1"
end
