module Rbq
  module Middleware
    module Deserialize
      class String
        def initialize(app)
          @app = app
        end

        def call(data)
          @app.call(data.to_s)
        end
      end
    end
  end
end
