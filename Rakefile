require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :README do
  task :generate do
    require 'rbq'

    tmpl = File.read('./data/README.md.erb')
    @dummy = File.read('./data/dummy.json').chomp

    ERB.new(tmpl).run(binding)
  end
end
