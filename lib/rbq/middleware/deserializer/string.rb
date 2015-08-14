module Rbq
  module Middleware
    module Deserializer
      class String
        def initialize(app, options={})
          @app = app
          @options = options
        end

        def call(data)
          @app.call(data.to_s)
        end
      end
    end
  end
end