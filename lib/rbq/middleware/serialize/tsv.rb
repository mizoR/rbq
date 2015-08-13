module Rbq
  module Middleware
    module Serialize
      class TSV < CSV
        def initialize(app, options={})
          super app, options.reverse_merge(col_sep: "\t")
        end
      end
    end
  end
end
