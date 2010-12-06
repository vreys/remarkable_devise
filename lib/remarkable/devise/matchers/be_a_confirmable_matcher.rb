module Remarkable
  module Devise
    module Matchers
      class BeAConfirmableMatcher < Base
        arguments
        
        assertion :included?, :has_confirmation_token_column?, :has_confirmed_at_column?,
        :has_confirmation_sent_at_column?, :confirmation_period_matches?

        optional :confirm_within

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::Confirmable)
        end

        def confirmation_period_matches?
          return true unless @options.key?(:confirm_within)

          return subject_class.confirm_within == @options[:confirm_within], :actual => subject_class.confirm_within.inspect
        end
      end

      def be_a_confirmable(*args, &block)
        BeAConfirmableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end
