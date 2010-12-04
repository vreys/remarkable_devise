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
   
    # spec/models/user_spec.rb   
    describe User do
      should_be_a_database_authenticatable
      should_be_a_confirmable
      should_be_a_reciverable
      should_be_a_rememberable
      should_be_a_trackable
    end

## See alse

* [http://github.com/remarkable/remarkable](http://github.com/remarkable/remarkable)
* [http://github.com/plataformatec/devise](http://github.com/plataformatec/devise)
* [http://github.com/rspec/rspec](http://github.com/rspec/rspec)
