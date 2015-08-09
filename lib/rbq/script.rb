module Rbq
  class Script
    DEFAULT_SCRIPT = 'itself'

    attr_reader :script, :src_opts, :dst_opts

    def initialize(script, src:, dst:)
      @script = script || DEFAULT_SCRIPT
      @src_opts = src
      @dst_opts = dst
    end

    def run(data)
      source = Source.new(data, src_opts)
      result = Evaluator.new(source).evaluate(script)
      Destination.new(result, dst_opts)
    end
  end
end
