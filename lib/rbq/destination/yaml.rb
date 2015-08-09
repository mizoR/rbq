require 'yaml'

module Rbq
  module Destination
    class YAML < Abstract
      def to_s
        yaml = ::YAML.dump(@data)
        yaml = highlight(yaml, lexer: 'yaml') if colorize?
        yaml
      end
    end
  end
end
