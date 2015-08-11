module Rbq
  module Middleware
    class Redirect
        def initialize(app, options={})
          @app = app
          @out = options[:to]
        end

        def call(data)
          data = @app.call(data)
          @out.puts data
          data
        end
    end
  end
end
