module Remarkable
  module Devise
    module Matchers
      class BeAConfirmableMatcher < Base
        assertion :included?, :has_confirmation_token_column?, :has_confirmed_at_column?,
        :has_confirmation_sent_at_column?

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::Confirmable)
        end
      end

      def be_a_confirmable
        BeAConfirmableMatcher.new
      end
    end
  end
end
