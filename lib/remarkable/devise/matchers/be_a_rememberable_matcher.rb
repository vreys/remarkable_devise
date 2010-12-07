module Remarkable
  module Devise
    module Matchers
      class BeARememberableMatcher < Base
        arguments
        
        assertions :included?, :has_remember_token_column?, :has_remember_created_at_column?, :options_match?

        optionals :remember_for, :extend_remember_period, :cookie_domain

        protected

        def included?
          subject_class.include?(::Devise::Models::Rememberable)
        end
      end

      def be_a_rememberable(*args, &block)
        BeARememberableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end
