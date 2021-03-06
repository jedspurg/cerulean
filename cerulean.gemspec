# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cerulean/version'

Gem::Specification.new do |spec|
  spec.name          = 'cerulean'
  spec.version       = Cerulean::VERSION
  spec.authors       = ['Tony Drake']
  spec.email         = ['t27duck@gmail.com']

  spec.summary       = 'Quick record-specific configuration for your models'
  spec.description   = <<-DESC
    Allows you to include and organize configuration options for each record in
    a model without the need of complex joins to settings tables or constantly
    adding random boolean and string columns
  DESC
  spec.homepage      = 'https://github.com/t27duck/cerulean'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'activerecord', '>= 4.0'
  spec.add_development_dependency 'activesupport', '>= 4.0'
  spec.add_development_dependency 'pg'
end
