require 'rbq/middleware/deserialize/void'

module Rbq
  module Middleware
    module Deserialize
      extend ActiveSupport::Autoload

      Deserializers = {
        'json'   => :JSON,
        'yaml'   => :YAML,
        'csv'    => :CSV,
        'string' => :String,
      }

      Deserializers.each do |_, deserializer|
        autoload deserializer
      end

      class << self
        def [](key)
          deserializer = Deserializers.fetch(key.to_s)
          const_get(deserializer, false)
        end
      end
    end
  end
end
