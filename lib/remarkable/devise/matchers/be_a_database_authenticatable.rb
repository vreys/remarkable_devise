module Remarkable
  module Devise
    module Matchers
      class BeADatabaseAuthenticatableMatcher < Base
        assertion :included?, :has_email_column?, :has_encrypted_password_column?, :has_password_salt_column?

        protected
        
        def included?
          subject_class.ancestors.include?(::Devise::Models::DatabaseAuthenticatable)
        end

        def has_email_column?
          has_column?('email')
        end

        def has_encrypted_password_column?
          has_column?('encrypted_password')
        end

        def has_password_salt_column?
          has_column?('password_salt')
        end
      end
      
      def be_a_database_authenticatable
        BeADatabaseAuthenticatableMatcher.new
      end
    end
  end
end
