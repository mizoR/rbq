require 'csv'

module Rbq
  module Middleware
    module Serializer
      class CSV
        def initialize(app, options={})
          @app = app
          @options = options
        end

        def call(data)
          data = @app.call(data)
          generate(data, @options)
        end

        private

        def generate(data, options)
          ::CSV.generate('', options) do |csv|
            data = Array.wrap(data)
            data.each {|row| csv << Array.wrap(row) }
          end
        end
      end
    end
  end
end
