module Remarkable
  module Devise
    module Matchers
      class BeADatabaseAuthenticatableMatcher < Remarkable::ActiveRecord::Base
        assertion :includes?, :has_email_column?, :has_encrypted_password_column?, :has_password_salt_column?

        protected
        
        def includes?
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

        def has_column?(column_name)
          subject_class.column_names.include?(column_name)
        end
      end
      
      def be_a_database_authenticatable
        BeADatabaseAuthenticatableMatcher.new
      end
    end
  end
end
