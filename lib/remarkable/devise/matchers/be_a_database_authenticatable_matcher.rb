module Remarkable
  module Devise
    module Matchers
      class BeADatabaseAuthenticatableMatcher < Base
        arguments
        assertion :included?, :has_email_column?, :has_encrypted_password_column?, :has_password_salt_column?,
        :stretches_match?, :encryptor_match?

        optionals :stretches, :encryptor

        protected
        
        def included?
          subject_class.ancestors.include?(::Devise::Models::DatabaseAuthenticatable)
        end

        def stretches_match?
          return true unless @options.key?(:stretches)

          return subject_class.stretches == @options[:stretches], :actual => subject_class.stretches.inspect
        end

        def encryptor_match?
          return true unless @options.key?(:encryptor)

          return subject_class.encryptor == @options[:encryptor], :actual => subject_class.encryptor.inspect
        end
      end
      
      def be_a_database_authenticatable(*args, &block)
        BeADatabaseAuthenticatableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end
