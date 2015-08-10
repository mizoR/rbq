require 'csv'

module Rbq
  module Middleware
    module Deserialize
      class CSV
        def initialize(app, fs=nil, rs=nil)
          @app = app
          @fs, @rs = fs, rs
        end

        def call(data)
          data = ::CSV.parse(data, @fs, @rs)
          @app.call(data)
        end
      end
    end
  end
end
