module Remarkable
  module Devise
    module Matchers
      class BeATimeoutableMatcher < Base
        arguments
        
        assertion :included?, :options_match?

        optional :timeout_in

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::Timeoutable)
        end
      end

      def be_a_timeoutable(*args, &block)
        BeATimeoutableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end
