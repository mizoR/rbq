require 'yaml'

module Rbq
  module Middleware
    module Serializer
      class YAML
        def initialize(app, options={})
          @app = app
          @options = options
        end

        def call(data)
          data = @app.call(data)
          ::YAML.dump(data)
        end
      end
    end
  end
end
