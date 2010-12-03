# Load remarkable
require 'remarkable/core'
require 'remarkable/active_record'

# Load devise
require 'devise'
require 'devise/orm/active_record'

dir = File.dirname(__FILE__)

# Add matchers
Dir[File.join(dir, 'matchers', '*.rb')].each do |file|
  require file
end

Remarkable.include_matchers!(Remarkable::Devise, RSpec::Core::ExampleGroup)
