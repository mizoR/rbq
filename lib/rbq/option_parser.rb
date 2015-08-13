require 'optparse'

module Rbq
  class OptionParser < ::OptionParser
    SCRIPT_NAME = File.basename($0)

    BANNER = <<-BNR.strip_heredoc
        Usage:
            $ #{SCRIPT_NAME} [options] <script> [file ...]
    BNR

    SEPARATOR = "\nOptions:"

    DEFAULT_FORMAT = 'json'.freeze

    def initialize
      super do |opt|
        opt.banner  = BANNER
        opt.version = Rbq::VERSION
        opt.separator SEPARATOR

        opt.on(      '--format  FORMAT', 'Load and dump format') {|v| @options[:from][:format] = @options[:to][:format] = v}
        opt.on(      '--from    FORMAT', 'Load format') {|v| @options[:from][:format] = v}
        opt.on(      '--to      FORMAT', 'Dump format') {|v| @options[:to][:format] = v}
        opt.on('-r', '--require LIBRARY', 'Require specified library') {|v| require v}
      end
    end

    def parse(argv)
      @options = {
        from: { format: DEFAULT_FORMAT, options: {} },
        to:   { format: DEFAULT_FORMAT, options: {} },
      }
      super(argv) + [@options]
    end
  end
end
