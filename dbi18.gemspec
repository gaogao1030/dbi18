# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dbi18/version'

Gem::Specification.new do |spec|
  spec.name          = "dbi18"
  spec.version       = Dbi18::VERSION
  spec.authors       = ["pockycat"]
  spec.email         = ["gaogao1130@gmail.com"]
  spec.description   = "i18n in Database"
  spec.summary       = "dbi18 gem"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "activerecord", ">= 3.0.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency 'rspec', ">= 2.0"
  spec.add_development_dependency "rspec-rails", ">= 2.0"
end
