require 'json'

module Rbq
  module Middleware
    module Deserialize
      class JSON
        def initialize(app, options={})
          @app = app
          @options = options.reverse_merge(quircks_mode: true)
        end

        def call(data)
          data = ::JSON.parse(data, @options)
          @app.call(data)
        end
      end
    end
  end
end
