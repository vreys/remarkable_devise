module Remarkable
  module Devise
    module Matchers
      class BeAnAuthenticatableMatcher < Base
        arguments
        
        assertion :has_authenticatable_module_included?, :options_match?

        optionals :authentication_keys, :params_authenticatable
        
        protected

        def has_authenticatable_module_included?
          subject_class.ancestors.include?(::Devise::Models::Authenticatable)
        end
      end
    end
  end
end
