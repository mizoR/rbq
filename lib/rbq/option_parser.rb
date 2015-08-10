require 'optparse'
require 'forwardable'

module Rbq
  module OptionParser
    SCRIPT_NAME = File.basename($0)

    BANNER = <<-BNR.strip_heredoc
        Usage:
            $ #{SCRIPT_NAME} [options] <script> [file]
      BNR

    SEPARATOR = "\nOptions:"

    DEFAULT_FORMAT = 'json'.freeze

    class << self
      extend Forwardable
      def_delegator :@last_parser, :help

      def parse!(argv)
        options = {from: DEFAULT_FORMAT, to: DEFAULT_FORMAT}
        options.tap do |opts|
          @last_parser = ::OptionParser.new do |o|
            o.banner  = BANNER
            o.version = Rbq::VERSION
            o.separator SEPARATOR

            o.on('--from FORMAT', 'Import format') {|v| opts[:from] = v}
            o.on('--to FORMAT', 'Dump format') {|v| opts[:to] = v}

            o.parse!(argv)
          end
        end
      end
    end
  end
end
