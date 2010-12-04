module Remarkable
  module Devise
    module Matchers
      class Base < Remarkable::ActiveRecord::Base
        protected
        
        def has_column?(column_name)
          subject_class.column_names.include?(column_name)
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
