module Rbq
  module Middleware
    module Deserialize
      class String < Void
        def call(data)
          @app.call(data.to_s)
        end
      end
    end
  end
end
