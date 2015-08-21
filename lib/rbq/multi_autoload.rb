module Rbq
  module MultiAutoload
    def self.extended(klass)
      klass.extend ActiveSupport::Autoload
    end

    def multi_autoload(*class_names)
      class_names.each do |class_name|
        autoload class_name
      end
    end
  end
end
