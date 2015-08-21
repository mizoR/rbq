require 'rbq/multi_autoload'
require 'rbq/const_index_access'

module Rbq
  module Parser
    extend MultiAutoload
    extend ConstIndexAccess

    PARSERS = [:JSON]

    const_index_access(*PARSERS)
    multi_autoload(*PARSERS)
  end
end
