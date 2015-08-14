require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/its'
require 'rbq'
require 'rbq/cli'

require 'json'
require 'yaml'
require 'csv'
require 'ltsv'
