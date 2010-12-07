require 'mocha'

require File.join(File.dirname(__FILE__), '..', 'lib', 'remarkable', 'devise')

require 'example_models'
require 'shared_examples'

ActiveRecord::Base.establish_connection( :adapter => 'sqlite3',
                                         :database => ':memory:' )

connection = ActiveRecord::Base.connection

begin
  connection.execute("DROP TABLE IF EXISTS `users`")
  connection.create_table('users')
rescue Exception => e
  connection.execute("DROP TABLE IF EXISTS `users`")
  raise e
end

RSpec.configure do |config|
  config.mock_with :mocha
end
