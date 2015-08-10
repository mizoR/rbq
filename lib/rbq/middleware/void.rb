module Rbq
  module Middleware
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
