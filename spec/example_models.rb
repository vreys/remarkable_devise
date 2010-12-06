class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable,
  :rememberable, :trackable, :validatable, :token_authenticatable,
  :confirm_within => 2.days
end

class FooUser < ActiveRecord::Base
end
