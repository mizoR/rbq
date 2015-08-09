require 'optparse'
require 'forwardable'

module Rbq
  module OptionParser
    SCRIPT_NAME = File.basename($0)

    BANNER = <<-BNR.strip_heredoc
        Usage:
            $ #{SCRIPT_NAME} [options] <script>"

        Example:
            $ #{SCRIPT_NAME} [options] <script>" < ./path/to/input.json
            $ cat ./path/to/input.json | #{File.basename($0)} [options] <script>"
      BNR

    SEPARATOR = "\nOptions:"

    class << self
      extend Forwardable
      def_delegator :@last_parser, :help

      def parse!(argv)
        options = {src: {}, dst: {}}
        options.tap do |opts|
          @last_parser = ::OptionParser.new do |o|
            o.banner  = BANNER
            o.version = Rbq::VERSION
            o.separator SEPARATOR

            o.on('--[no-]quirks', 'Enable or disable quirks mode for JSON') do |v|
              opts[:src][:quirks_mode] = opts[:dst][:quirks_mode] = v
            end

            o.on('--src-format FORMAT', 'Parse stdin as specified format') do |v|
              opts[:src][:format] = v
            end

            o.on('--dst-format FORMAT', 'Output results as specified format') do |v|
              opts[:dst][:format] = v
            end

            o.on('-r LIBRARY', '--require LIBRARY', "`require` a Ruby script at startup") do |v|
              require v
            end

            o.parse!(argv)
          end
        end
      end
    end
  end
end
