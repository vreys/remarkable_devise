module Remarkable
  module Devise
    module Matchers
      class Base < Remarkable::ActiveRecord::Base
        def has_column?(column_name)
          subject_class.column_names.include?(column_name)
        end        
      end
    end
  end
end
