require 'rbq/multi_autoload'
require 'rbq/const_index_access'

module Rbq
  module Middleware
    module Serializer
      extend Rbq::MultiAutoload
      extend Rbq::ConstIndexAccess

      SERIALIZERS = [:JSON, :CSV, :TSV]

      const_index_access(*SERIALIZERS)
      multi_autoload(*SERIALIZERS)
    end
  end
end
