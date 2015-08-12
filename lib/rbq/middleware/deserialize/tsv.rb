require 'csv'

module Rbq
  module Middleware
    module Deserialize
      class TSV
        def initialize(app, options={})
          @app = app
          @options = options.reverse_merge(col_sep: "\t")
        end

        def call(data)
          data = ::CSV.parse(data, @options)
          @app.call(data)
        end
      end
    end
  end
end
