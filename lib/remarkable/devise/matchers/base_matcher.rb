module Remarkable
  module Devise
    module Matchers
      class Base < Remarkable::ActiveRecord::Base
        protected
        
        def has_column?(column_name)
          subject_class.column_names.include?(column_name)
        end

        def options_match?
          actual = get_devise_model_options(@options.keys)

          return actual == @options, :actual => actual.inspect
        end

        def get_devise_model_options(keys)
          keys.inject({}) do |hash, key|
            hash[key] = subject_class.send(key.to_sym)
            hash
          end
        end

        def interpolation_options
          { :options => @options.inspect }
        end

        def method_missing(m, *args)
          if m.to_s.match(/has_(.+)_column?/)
            return has_column?($1)
          end
          
          super
        end
      end
    end
  end
end
