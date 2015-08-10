require 'yaml'

module Rbq
  module Middleware
    module Deserialize
      class YAML
        def initialize(app, options={})
          @app = app
        end

        def call(data)
          data = ::YAML.load(data)
          @app.call(data)
        end
      end
    end
  end
end
