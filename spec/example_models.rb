class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable
end

class FooUser < ActiveRecord::Base
end
