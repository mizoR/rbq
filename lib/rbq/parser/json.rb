require 'yajl'

module Rbq
  module Parser
    class JSON
      def initialize(app, options={})
        @app = app
        @options = options.reverse_merge(symbolize_keys: true)
      end

      def parse(input, &block)
        Yajl::Parser.parse(input, @options, nil, &block)
      end
    end
  end
end
