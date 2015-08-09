require 'rbq/destination/abstract'
require 'rbq/destination/json'
require 'rbq/destination/yaml'
require 'rbq/destination/ruby'
require 'rbq/destination/text'

module Rbq
  module Destination
    DEFAULT_FORMAT = 'json'

    FormatClassFetcher = {
      'json' => Destination::JSON,
      'yaml' => Destination::YAML,
      'ruby' => Destination::Ruby,
      'text' => Destination::Text,
    }

    def self.new(data, options={})
      format = (options.delete(:format) || DEFAULT_FORMAT).to_s
      FormatClassFetcher.fetch(format).new(data, options)
    end
  end
end
