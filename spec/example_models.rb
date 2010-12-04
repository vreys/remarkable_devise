class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable, :rememberable
end

class FooUser < ActiveRecord::Base
end
