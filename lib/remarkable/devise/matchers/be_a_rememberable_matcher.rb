module Remarkable
  module Devise
    module Matchers
      class BeARememberableMatcher < Base
        assertions :included?, :has_remember_token_column?, :has_remember_created_at_column?

        protected

        def included?
          subject_class.include?(::Devise::Models::Rememberable)
        end
      end

      def be_a_rememberable
        BeARememberableMatcher.new
      end
    end
  end
end
