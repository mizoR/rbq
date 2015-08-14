module Rbq
  module Middleware
    module Serializer
      extend Middleware::MultiAutoload
      extend Middleware::ConstIndexAccess

      SERIALIZERS = [:JSON, :YAML, :CSV, :TSV, :String]

      const_index_access(*SERIALIZERS)
      multi_autoload(*SERIALIZERS)
    end
  end
end
