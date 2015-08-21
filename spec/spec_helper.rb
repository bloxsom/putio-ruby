require 'bundler/setup'
Bundler.setup

require 'putio'
require 'pry'

require 'support/faraday_helper'

RSpec.configure do |config|
  config.include FaradayHelper
end
