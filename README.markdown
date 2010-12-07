# Remarkable Devise

Remarkable Devise is a collection of RSpec matchers for [Devise](http://github.com/plataformatec/devise).

## Install

Add to your Gemfile:

    gem "remarkable_activerecord"
    gem "remarkable_devise"

Add the require after the remarkable/active_record line in your spec_heplers.rb:

    require 'remarkable/active_record'
    require 'remarkable/devise'

## Usage

Suppose that we require authentication of users. And we want to use Devise. The problem that we face a number of requirements:

* The user must be authorized by email or login
* Password should contain 8 to 20 characters
* After 3 unsuccessful attempts to authenticate, the account should be locked in 5 hours
* and much more

Following the BDD way, we first write a specs:
   
    # spec/models/user_spec.rb   
    describe User do
      it { should be_a_confirmable(:confirm_within => 2.days) }
      it { should be_a_rememberable(:remember_for => 2.weeks) }
      it { should be_a_validatable(:password_length => 8..20) }
      it { should be_a_timeoutable(:timeout_in => 15.minutes) }
      it { should be_a_token_authenticatable(:token_authentication_key => :auth_token) }
      it { should be_a_trackable }
      it { should be_a_registerable }
      it { should be_a_recoverable }

      should_be_a_lockable do |o|
        o.lock_strategy = :failed_attempts
        o.maximum_attempts => 3
        o.unlock_strategy => :time
      end
  
      should_be_a_database_authenticatable do |o|
        o.stretches = 20
        o.encryptor = :clearance_sha1
        o.params_authenticatable = false
        o.authentication_keys = [:email, :login]
      end
    end

After number of steps (red/green/refactor) we will get the following
result (assuming that you are familiar with how to use Devise and
know what to do):
     
     # app/models/user.rb
     class User < ActiveRecord::Base
       devise :database_authenticatable, :stretches => 20, :encryptor => :clearance_sha1, 
       :authentication_keys => [:email, :login], :params_authenticatable => false
  
       devise :confirmable, :confirm_within => 2.days
       devise :recoverable
       devise :rememberable, :remember_for => 2.weeks, :extend_remember_period => true
       devise :trackable
       devise :validatable, :password_length => 8..20
       devise :token_authenticatable, :token_authentication_key => :auth_token
       devise :timeoutable, :timeout_in => 15.minutes
       
       devise :lockable, :maximum_attempts => 3, :lock_strategy => :failed_attempts, 
       :unlock_strategy => :time, :unlock_in => 5.hours
       
       devise :registerable
     end

     # rspec spec/models/user_spec.rb --format=documentation
     User
       should be a confirmable within 2 days
       should be a rememberable with 14 days remember period and with extendable remember period
       should be a validatable with password length 8..20
       should be a timeoutable within 900 seconds
       should be a token authenticatable with :auth_token as authentication key
       should be a trackable
       should be a registerable
       should be a recoverable
       should be a lockable with :failed_attempts lock strategy, with :time unlock strategy, with unlock in 5 hours, and with 3 maxumum attempts
       should be a database authenticatable with [:email, :login] as authentication keys, without params authenticatable, with password stretches 20, and with :clearance_sha1 password encryptor

## Documentation

Coming soon

## See alse

* [http://github.com/remarkable/remarkable](http://github.com/remarkable/remarkable)
* [http://github.com/plataformatec/devise](http://github.com/plataformatec/devise)
* [http://github.com/rspec/rspec](http://github.com/rspec/rspec)
