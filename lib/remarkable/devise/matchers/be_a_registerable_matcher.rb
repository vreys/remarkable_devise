module Remarkable
  module Devise
    module Matchers
      class BeARegisterableMatcher < Base
        assertion :included?

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::Registerable)
        end
      end

      def be_a_registerable
        BeARegisterableMatcher.new.spec(self)
      end
    end
  end
end
