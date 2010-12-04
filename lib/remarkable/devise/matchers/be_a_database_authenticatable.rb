module Remarkable
  module Devise
    module Matchers
      class BeADatabaseAuthenticatableMatcher < Base
        assertion :included?, :has_email_column?, :has_encrypted_password_column?, :has_password_salt_column?

        protected
        
        def included?
          subject_class.ancestors.include?(::Devise::Models::DatabaseAuthenticatable)
        end
      end
      
      def be_a_database_authenticatable
        BeADatabaseAuthenticatableMatcher.new
      end
    end
  end
end
