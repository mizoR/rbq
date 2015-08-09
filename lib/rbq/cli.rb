require 'rbq'
require 'rbq/option_parser'

module Rbq
  class CLI
    class << self
      def start(argv=ARGV)
        new(argv.dup).run
      end
    end

    attr_reader :parser, :script, :options

    def initialize(argv)
      @options  = Rbq::OptionParser.parse!(argv)
      @script  = argv.first
    end

    def run
      if STDIN.tty?
        puts Rbq::OptionParser.help
      else
        puts Script.new(script, options).run(STDIN.read)
      end
    end
  end
end
