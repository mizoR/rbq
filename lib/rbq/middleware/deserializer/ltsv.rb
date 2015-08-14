require 'ltsv'

module Rbq
  module Middleware
    module Deserializer
      class LTSV
        def initialize(app, options={})
          @app = app
          @options = options
        end

        def call(data)
          data = ::LTSV.parse(data, @options)
          @app.call(data)
        end
      end
    end
  end
end
