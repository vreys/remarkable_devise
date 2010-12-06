module Remarkable
  module Devise
    module Matchers
      class BeATokenAuthenticatableMatcher < Base
        assertions :included?, :has_authentication_token_column?

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::TokenAuthenticatable)
        end
      end

      def be_a_token_authenticatable
        BeATokenAuthenticatableMatcher.new
      end
    end
  end
end
