module Remarkable
  module Devise
    module Matchers
      class BeATrackableMatcher < Base
        assertions :included?, :has_sign_in_count_column?, :has_current_sign_in_at_column?,
        :has_last_sign_in_at_column?, :has_current_sign_in_ip_column?, :has_last_sign_in_ip_column?

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::Trackable)
        end
      end

      def be_a_trackable
        BeATrackableMatcher.new
      end
    end
  end
end
