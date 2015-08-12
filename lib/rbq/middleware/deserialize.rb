module Rbq
  module Middleware
    module Deserialize
      extend Middleware::MultiAutoload
      extend Middleware::ConstIndexAccess

      DESERIALIZERS = [:JSON, :YAML, :CSV, :TSV, :String]

      const_index_access(*DESERIALIZERS)
      multi_autoload(*DESERIALIZERS)
    end
  end
end
