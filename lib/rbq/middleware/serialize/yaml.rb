require 'yaml'

module Rbq
  module Middleware
    module Serialize
      class YAML < Void
        def call(data)
          data = @app.call(data)
          ::YAML.dump(data)
        end
      end
    end
  end
end
