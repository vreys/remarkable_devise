require 'rails'
require 'active_record'

require File.join(File.dirname(__FILE__), '..', 'lib', 'remarkable_devise')

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

RSpec.configure do |config|
  config.mock_with :rspec
end
