require 'pygments'

module Rbq
  module Destination
    class Abstract
      def initialize(data, options={})
        @data = data
        @options = options
      end

      def to_s
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      private

      def colorize?
        (STDOUT.tty? && ((ENV['TERM'] && ENV['TERM'] != 'dumb') || ENV['ANSICON']))
      end

      def highlight(code, options={})
        options = options.reverse_merge(formatter: 'terminal')
        Pygments.highlight(code, options)
      end
    end
  end
end
