module Rbq
  class Error < StandardError
    def self.from(e)
      new(e.message)
    end
  end
end
