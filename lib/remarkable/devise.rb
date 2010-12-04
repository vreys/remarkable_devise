# Load rails and AR
require 'rails'
require 'active_record'

# Load remarkable
require 'remarkable/core'
require 'remarkable/active_record'

# Load devise
require 'devise'
require 'devise/orm/active_record'

dir = File.dirname(__FILE__)

# Add default locale
Dir["#{dir}/../../locale/*yml"].each {|f| Remarkable.add_locale(f) }

# Add matchers
require(File.join(dir, 'devise', 'matchers', 'base_matcher.rb'))

Dir[File.join(dir, 'devise', 'matchers', '*.rb')].each do |file|
  require file
end

Remarkable.include_matchers!(Remarkable::Devise, RSpec::Core::ExampleGroup)
