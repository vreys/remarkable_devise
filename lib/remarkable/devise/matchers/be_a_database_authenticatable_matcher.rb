require File.join(File.dirname(__FILE__), 'be_an_authenticatable_matcher')

module Remarkable
  module Devise
    module Matchers
      class BeADatabaseAuthenticatableMatcher < BeAnAuthenticatableMatcher
        arguments

        assertion :included?, :has_email_column?, :has_encrypted_password_column?, :options_match?

        optionals :stretches, :encryptor

        protected
        
        def included?
          subject_class.ancestors.include?(::Devise::Models::DatabaseAuthenticatable)
        end
      end
      
      def be_a_database_authenticatable(*args, &block)
        BeADatabaseAuthenticatableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end
