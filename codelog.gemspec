# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'codelog/version'

Gem::Specification.new do |spec|
  spec.name          = 'codelog'
  spec.version       = CodeLog::VERSION
  spec.authors       = ['Douglas Mills']
  spec.email         = ['slipdigital@gmail.com']
  spec.description   = %q{A library for inspecting the local git repos and reporting on activity}
  spec.summary       = %q{Inspects git history and file modified dates to determine work activity }
  spec.homepage      = 'https://github.com/slipdigital'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_dependency 'git', '~> 1.2.9'

  spec.add_development_dependency 'minitest', '~> 4.7'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.8'
  spec.add_development_dependency 'simplecov-bamboo', '~> 0.1'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.1'
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
end
