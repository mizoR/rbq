require 'optparse'

module Rbq
  class OptionParser < ::OptionParser
    SCRIPT_NAME = File.basename($0)

    BANNER = <<-BNR.strip_heredoc
        Usage:
            $ #{SCRIPT_NAME} [options] <script> [file ...]
    BNR

    SEPARATOR = "\nOptions:"

    DEFAULT_SCRIPT = 'itself'.freeze
    DEFAULT_FORMAT = 'json'.freeze

    RE_NUMBER = %r|\A[1-9][0-9]*\z|
    RE_OPTION = %r|\A(\S+):(\S+)\z|

    def initialize
      super do |opt|
        opt.banner  = BANNER
        opt.version = Rbq::VERSION
        opt.separator SEPARATOR

        opt.on(      '--format       FORMAT', 'Load and dump format') {|v| @options[:from][:format] = @options[:to][:format] = v}
        opt.on(      '--from         FORMAT', 'Load format') {|v| @options[:from][:format] = v}
        opt.on(      '--to           FORMAT', 'Dump format') {|v| @options[:to][:format] = v}
        opt.on(      '--from-options FORMAT', 'Load format options') {|v| merge_options!(@options[:from][:options], v)}
        opt.on(      '--to-options   FORMAT', 'Dump format options') {|v| merge_options!(@options[:to][:options], v)}
        opt.on('-r', '--require      LIBRARY', 'Require specified library') {|v| require v}
      end
    end

    def parse(argv)
      @options = {
        from: { format: DEFAULT_FORMAT, options: {} },
        to:   { format: DEFAULT_FORMAT, options: {} },
      }
      argv = super(argv)
      argv << DEFAULT_SCRIPT if argv.empty?
      argv + [@options]
    end

    private

    def merge_options!(options, value)
      if value =~ RE_OPTION
        key, value = $1, $2
        options.merge!(key.to_sym => cast(value))
      else
        warn "Option was ignored. (value: #{value.inspect})"
      end
    end

    def cast(value)
      case value
      when 'true'    then true
      when 'false'   then false
      when RE_NUMBER then value.to_i
      else value
      end
    end
  end
end
