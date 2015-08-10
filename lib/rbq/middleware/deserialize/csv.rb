require 'csv'

module Rbq
  module Middleware
    module Deserialize
      class CSV < Void
        def call(data)
          data = ::CSV.parse(data, @options)
          @app.call(data)
        end
      end
    end
  end
end
