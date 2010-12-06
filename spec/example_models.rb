class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable,
  :rememberable, :trackable, :validatable, :token_authenticatable
end

class FooUser < ActiveRecord::Base
end
