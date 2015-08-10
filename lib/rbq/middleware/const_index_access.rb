module Rbq
  module Middleware
    module ConstIndexAccess
      def [](class_key)
        const_name = @index_accessible_consts.fetch(class_key.to_s)
        const_get(const_name)
      end

      def const_index_access(*class_names)
        @index_accessible_consts = class_names.inject({}) {|hash, class_name|
          hash[class_name.to_s.downcase] = class_name
          hash
        }
      end
    end
  end
end
