$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "remarkable/devise/version"

Gem::Specification.new do |s|
  s.name        = "remarkable_devise"
  s.version     = Remarkable::Devise::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vasily Reys"]
  s.email       = "reys.vasily@gmail.com"
  s.homepage    = "http://github.com/vreys/remarkable_devise"
  s.summary     = "Devise remarkable rspec matchers"
  s.description = "remarkable_devise is a collection of RSpec matchers for Devise"

  s.rubygems_version  = "1.3.7"
  s.rubyforge_project = "remarkbl-devise"

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = "lib"

  s.add_runtime_dependency(%q<rspec>, [">=2.1.0"])
  s.add_runtime_dependency(%q<rails>, [">=3.0.1"])
  s.add_runtime_dependency(%q<activerecord>, [">=3.0.1"])
  s.add_runtime_dependency(%q<remarkable_activerecord>, [">=4.0.0.alpha4"])
  s.add_runtime_dependency(%q<devise>, [">=1.1.3"])

  s.add_development_dependency "mocha"
end
