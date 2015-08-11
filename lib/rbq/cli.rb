require 'rbq'
require 'rbq/option_parser'

module Rbq
  class CLI
    class << self
      def start(argv=ARGV)
        new(argv.dup).run
      end
    end

    attr_reader :parser, :script, :code, :file

    def initialize(argv)
      options = Rbq::OptionParser.parse!(argv)
      @code, @file = *argv[0..1]

      @script = Rbq::Script.new(argv.first) do |rbq|
        rbq.use Rbq::Middleware::Deserialize[options[:from]]
        rbq.use Rbq::Middleware::Serialize[options[:to]]
        rbq.use Rbq::Middleware::Colorize, lang: options[:to] if STDOUT.tty?
        rbq.use Rbq::Middleware::Redirect, to: $stdout
      end
    end

    def run(data=detect_data)
      script.run(data)
    end

    private

    def detect_data
      STDIN.tty? ? File.read(file) : STDIN.read
    end
  end
end
