module Remarkable
  module Devise
    module Matchers
      class BeADatabaseAuthenticatableMatcher < Base
        arguments

        assertion :included?, :has_email_column?, :has_encrypted_password_column?, :has_password_salt_column?,
        :options_match?

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
