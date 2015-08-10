module Rbq
  module Middleware
    module Deserialize
      class Void
        def initialize(app, options={})
          @app, @options = app, options
        end

        def call(data)
          @app.call(data)
        end
      end
    end
  end
end
