require 'coderay'

module Rbq
  module Middleware
    class Colorize
      def initialize(app, options)
        @app = app
        @lang = options[:lang]
      end

      def call(data)
        data = @app.call(data)
        CodeRay.scan(data, @lang).terminal
      end
    end
  end
end
