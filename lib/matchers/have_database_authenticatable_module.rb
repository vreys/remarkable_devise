module Remarkable
  module Devise
    module Matchers
      class HaveDatabaseAuthenticatableModuleMatcher < Remarkable::ActiveRecord::Base
        assertion :has_database_authenticatable_module?

        def has_database_authenticatable_module?
          subject = @subject.class == Class ? @subject : @subject.class

          subject.ancestors.include?(::Devise::Models::DatabaseAuthenticatable)
        end
      end
      
      def have_database_authenticatable_module
        HaveDatabaseAuthenticatableModuleMatcher.new
      end

      alias :be_a_database_authenticatable :have_database_authenticatable_module
    end
  end
end
