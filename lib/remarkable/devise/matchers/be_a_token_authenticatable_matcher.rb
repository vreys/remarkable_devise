module Remarkable
  module Devise
    module Matchers
      class BeATokenAuthenticatableMatcher < Base
        arguments
        
        assertions :included?, :has_authentication_token_column?, :options_match?

        optionals :token_authentication_key
        
        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::TokenAuthenticatable)
        end
      end

      def be_a_token_authenticatable(*args, &block)
        BeATokenAuthenticatableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end
