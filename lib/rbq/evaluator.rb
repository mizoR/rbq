module Rbq
  class Evaluator
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def evaluate(script)
      data.instance_eval(script)
    end
  end
end
