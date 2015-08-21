module Rbq
  module Middleware
    module Deserializer
      extend Middleware::MultiAutoload
      extend Middleware::ConstIndexAccess

      DESERIALIZERS = [:JSON, :CSV, :TSV]

      const_index_access(*DESERIALIZERS)
      multi_autoload(*DESERIALIZERS)
    end
  end
end
