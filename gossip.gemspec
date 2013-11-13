# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gossip/version'

Gem::Specification.new do |spec|
  spec.name          = 'gossip'
  spec.version       = Gossip::VERSION
  spec.authors       = ['Corey Ward']
  spec.email         = ['corey.atx@gmail.com']
  spec.description   = %q{Gossip quickly gathers social share counts.}
  spec.summary       = %q{Gossip quickly gathers social share counts from leading social networks such as Facebook, Twitter, and Google Plus.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'typhoeus', '~> 0.6.3'
  spec.add_dependency 'activesupport', '~> 3.2'
  spec.add_dependency 'multi_json', '~> 1.8.2'
  spec.add_dependency 'nokogiri'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'
end
