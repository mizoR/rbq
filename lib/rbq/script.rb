module Rbq
  class Script
    DEFAULT_SCRIPT = 'itself'

    attr_reader :script

    def initialize(script)
      @script = script || DEFAULT_SCRIPT

      yield self if block_given?

      @app = build
    end

    def use(middleware_klass, *middleware_options)
      middlewares << [middleware_klass, middleware_options]
    end

    def build
      middlewares.inject(self) {|app, (klass, options)| klass.new(app, *options)}
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
