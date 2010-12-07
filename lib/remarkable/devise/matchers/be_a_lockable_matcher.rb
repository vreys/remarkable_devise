module Remarkable
  module Devise
    module Matchers
      class BeALockableMatcher < Base
        arguments
        
        assertion :included?, :has_failed_attempts_column?, :has_unlock_token_column?, :has_locked_at_column?,
        :options_match?

        optionals :maximum_attempts, :lock_strategy, :unlock_strategy, :unlock_in

        protected

        def included?
          subject_class.ancestors.include?(::Devise::Models::Lockable)
        end

        def has_failed_attempts_column?
          return true if subject_class.lock_strategy == :none
          super
        end

        def has_unlock_token_column?
          return true unless [:email, :both].include?(subject_class.unlock_strategy)
          super
        end
      end

      def be_a_lockable(*args, &block)
        BeALockableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end
