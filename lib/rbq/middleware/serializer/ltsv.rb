require 'ltsv'

module Rbq
  module Middleware
    module Serializer
      class LTSV
        def initialize(app, options={})
          @app = app
          @options = options
        end

        def call(data)
          data = @app.call(data)
          Array.wrap(data).inject('') do |ltsv, row|
            ltsv << ::LTSV.dump(row) << "\n"
          end
        end
      end
    end
  end
end
