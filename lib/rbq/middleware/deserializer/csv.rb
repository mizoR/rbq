require 'csv'

module Rbq
  module Middleware
    module Deserializer
      class CSV
        def initialize(app, options={})
          @app = app
          @options = options
        end

        def call(data)
          data = ::CSV.parse(data, @options)
          @app.call(data)
        end
      end
    end
  end
end
