require 'json'

module Rbq
  module Destination
    class JSON < Abstract
      def to_s
        options = @options.reverse_merge(quirks_mode: true)
        json = ::JSON.pretty_generate(@data, options)
        json = highlight(json, lexer: 'json') if colorize?
        json
      end
    end
  end
end
