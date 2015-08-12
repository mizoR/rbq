require 'rbq'
require 'rbq/option_parser'

module Rbq
  class CLI
    class << self
      def start(argv=ARGV)
        new(argv.dup).run
      rescue Error => e
        $stderr.puts e.message
      end
    end

    attr_reader :parser

    def initialize(argv)
      @options = Rbq::OptionParser.parse!(argv)
      @script, *@files = *argv
    end

    def run
      each_run do |input, output|
        script = Rbq::Script.new(@script) do |rbq|
          rbq.use Rbq::Middleware::Deserialize[@options[:from]]
          rbq.use Rbq::Middleware::Serialize[@options[:to]]
          rbq.use Rbq::Middleware::Colorize, lang: @options[:to] if output.tty?
          rbq.use Rbq::Middleware::Redirect, to: output
        end

        script.run input.read
      end
    end

    def each_run
      return yield($stdin, $stdout) unless $stdin.tty?

      @files.each do |file|
        open(file) {|input| yield(input, $stdout)}
      end
    end
  end
end
