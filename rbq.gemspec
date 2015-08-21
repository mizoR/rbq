# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbq/version'

Gem::Specification.new do |spec|
  spec.name          = "rbq"
  spec.version       = Rbq::VERSION
  spec.authors       = ["mizokami"]
  spec.email         = ["r.mizokami@gmail.com"]

  spec.summary       = %q{Command-line processor like jq. rbq allows you to use the Ruby-syntax.}
  spec.description   = %q{Command-line processor like jq. rbq allows you to use the Ruby-syntax.}
  spec.homepage      = "https://github.com/mizoR/rbq"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "coderay"
  spec.add_dependency "yajl-ruby"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
end
