class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable
end

class FooUser < ActiveRecord::Base
end
