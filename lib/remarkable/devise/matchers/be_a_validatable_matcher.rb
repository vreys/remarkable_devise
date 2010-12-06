module Remarkable
  module Devise
    module Matchers
      class BeAValidatableMatcher < Base
        assertion :included?

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::Validatable)
        end
      end

      def be_a_validatable
        BeAValidatableMatcher.new
      end
    end
  end
end   
