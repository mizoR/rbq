module Rbq
  class Script
    DEFAULT_SCRIPT = 'itself'

    attr_reader :script

    def initialize(script, src:, dst:)
      @script = script || DEFAULT_SCRIPT
      @middleware_stack = []

      yield self if block_given?

      @app = build
    end

    def use(middleware_klass, *middleware_options)
      @middleware_stack << [middleware_klass, middleware_options]
    end

    def build
      @middleware_stack.inject(self) {|app, (klass, options)| klass.new(app, *options)}
    end

    def run(data)
      @app.call(data)
    end

    def call(source)
      Evaluator.new(source).evaluate(script)
    end

    def middlewares
      @middlewares ||= []
    end
  end
end
