require 'yaml'

module Rbq
  module Middleware
    module Deserialize
      class YAML < Void
        def call(data)
          data = ::YAML.load(data)
          @app.call(data)
        end
      end
    end
  end
end
