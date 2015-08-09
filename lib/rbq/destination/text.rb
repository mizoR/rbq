module Rbq
  module Destination
    class Text < Abstract
      def to_s
        @data.to_s
      end
    end
  end
end
