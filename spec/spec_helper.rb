require 'mocha'

require File.join(File.dirname(__FILE__), '..', 'lib', 'remarkable', 'devise')

require 'example_models'
require 'shared_examples'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

RSpec.configure do |config|
  config.mock_with :mocha
end
