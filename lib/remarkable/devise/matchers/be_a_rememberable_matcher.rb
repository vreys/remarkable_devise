module Remarkable
  module Devise
    module Matchers
      class BeARememberableMatcher < Base
        arguments
        
        assertions :included?, :has_remember_token_column?, :has_remember_created_at_column?, :options_match?

        optionals :remember_for, :extend_remember_period, :cookie_domain

        # before_assert do
        #   @options.each{|k,v| @options[k] = v.to_s}
        # end
        
        protected

        def included?
          subject_class.include?(::Devise::Models::Rememberable)
        end

        def options_match?
          actual = get_model_options(@options.keys)

          return actual == @options, :actual => actual.inspect
        end

        def get_model_options(keys)
          keys.inject({}) do |hash, key|
            hash[key] = subject_class.send(key.to_sym)
            hash
          end
        end

        def interpolation_options
          { :options => @options.inspect }
        end
      end

      def be_a_rememberable(*args, &block)
        BeARememberableMatcher.new(*args, &block).spec(self)
      end
    end
  end
end
