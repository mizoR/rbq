require 'yaml'

module Rbq
  module Middleware
    module Deserializer
      class YAML
        def initialize(app, options={})
          @app = app
          @options = options
        end

        def call(data)
          data = ::YAML.load(data)
          @app.call(data)
        end
      end
    end
  end
end
