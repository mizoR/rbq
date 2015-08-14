module Rbq
  module Middleware
    module Deserializer
      extend Middleware::MultiAutoload
      extend Middleware::ConstIndexAccess

      DESERIALIZERS = [:JSON, :YAML, :CSV, :TSV, :LTSV, :String]

      const_index_access(*DESERIALIZERS)
      multi_autoload(*DESERIALIZERS)
    end
  end
end