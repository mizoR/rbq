require 'json'

module Rbq
  module Middleware
    module Serialize
      class JSON < Void
        def initialize(app, options={})
          @app = app
          @options = options.reverse_merge(quircks_mode: true)
        end

        def call(data)
          data = @app.call(data)
          ::JSON.pretty_generate(data, @options)
        end
      end
    end
  end
end
