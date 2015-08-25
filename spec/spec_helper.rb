require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'bundler/setup'
Bundler.setup

require 'putio-ruby'
require 'pry'

require 'support/faraday_helper'

RSpec.configure do |config|
  config.include FaradayHelper
end
