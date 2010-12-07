class User < ActiveRecord::Base
  devise :database_authenticatable, :stretches => 15, :encryptor => :clearance_sha1
  devise :confirmable, :confirm_within => 2.days
  devise :recoverable
  devise :rememberable, :remember_for => 2.weeks, :extend_remember_period => true, :cookie_domain => 'foo'
  devise :trackable
  devise :validatable, :password_length => 8..20, :email_regexp => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
  devise :token_authenticatable, :token_authentication_key => :auth_token
  devise :timeoutable, :timeout_in => 15.minutes
  devise :lockable, :maximum_attempts => 10, :lock_strategy => :none, :unlock_strategy => :time, :unlock_in => 5.hours
end

class FooUser < ActiveRecord::Base
end
