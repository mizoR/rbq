require 'rbq'
require 'rbq/option_parser'

module Rbq
  class CLI
    class << self
      def start(argv=ARGV)
        new(argv.dup).run
      end
    end

    attr_reader :parser, :script

    def initialize(argv)
      options = Rbq::OptionParser.parse!(argv)
      input_opts  = options.delete(:input)
      output_opts = options.delete(:output)

      @script = Rbq::Script.new(argv.first) do |rbq|
        rbq.use Rbq::Middleware::Deserialize[input_opts.delete(:format)], input_opts
        rbq.use Rbq::Middleware::Serialize[output_opts.delete(:format)], output_opts
      end
    end

    def run
      if STDIN.tty?
        puts Rbq::OptionParser.help
      else
        puts script.run(STDIN.read)
      end
    end
  end
end
