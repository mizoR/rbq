require 'json'
require 'yaml'

module Rbq
  module Source
    DEFAULT_FORMAT = 'json'

    ParserFetcher = {
      'json' => -> (source, options) {::JSON.parse(source, options)},
      'yaml' => -> (source, options) {::YAML.load(source, options)},
      'text' => -> (source, options) {source},
    }

    def self.new(source, options = {})
      format = (options.delete(:format) || DEFAULT_FORMAT).to_s
      parser = ParserFetcher.fetch(format)
      parser.call(source, options)
    end
  end
end
