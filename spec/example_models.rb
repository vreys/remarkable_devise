class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable,
  :rememberable, :trackable, :validatable, :token_authenticatable,
  :confirm_within => 2.days, :stretches => 15, :encryptor => :clearance_sha1,
  :remember_for => 2.weeks, :extend_remember_period => true, :cookie_domain => 'foo',
  :password_length => 8..20, :email_regexp => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
end

class FooUser < ActiveRecord::Base
end
