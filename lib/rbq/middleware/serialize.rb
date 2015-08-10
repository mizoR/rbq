module Rbq
  module Middleware
    module Serialize
      extend ActiveSupport::Autoload

      Serializers = {
        'json'   => :JSON,
        'yaml'   => :YAML,
        'csv'    => :CSV,
        'string' => :String,
      }

      Serializers.each do |_, serializer|
        autoload serializer
      end

      class << self
        def [](key)
          serializer = Serializers.fetch(key.to_s)
          const_get(serializer, false)
        end
      end
    end
  end
end
