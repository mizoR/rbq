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
        options = {input: {format: 'json'}, output: {format: 'json'}}
        options.tap do |opts|
          @last_parser = ::OptionParser.new do |o|
            o.banner  = BANNER
            o.version = Rbq::VERSION
            o.separator SEPARATOR

            o.on('--[no-]symbolize-names') do |v|
              opts[:input][:symbolize_names] = v
            end

            o.on('--in FORMAT', 'Parse stdin as specified format') do |v|
              opts[:input][:format] = v
            end

            o.on('--out FORMAT', 'Output results as specified format') do |v|
              opts[:output][:format] = v
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
