class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable, :trackable
end

class FooUser < ActiveRecord::Base
end
