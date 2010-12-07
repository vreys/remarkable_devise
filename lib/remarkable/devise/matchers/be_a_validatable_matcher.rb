module Remarkable
  module Devise
    module Matchers
      class BeAValidatableMatcher < Base
        arguments
        
        assertion :included?, :options_match?

        optionals :password_length, :email_regexp

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::Validatable)
        end
      end

      def be_a_validatable(*args, &block)
        BeAValidatableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end   
