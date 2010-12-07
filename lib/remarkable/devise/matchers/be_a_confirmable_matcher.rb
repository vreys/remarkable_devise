module Remarkable
  module Devise
    module Matchers
      class BeAConfirmableMatcher < Base
        arguments
        
        assertion :included?, :has_confirmation_token_column?, :has_confirmed_at_column?,
        :has_confirmation_sent_at_column?, :options_match?

        optional :confirm_within

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::Confirmable)
        end
      end

      def be_a_confirmable(*args, &block)
        BeAConfirmableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end
