require 'yaml'

module Rbq
  module Middleware
    module Serialize
      class YAML
        def initialize(app, options={})
          @app = app
        end

        def call(data)
          data = @app.call(data)
          ::YAML.dump(data)
        end
      end
    end
  end
end
