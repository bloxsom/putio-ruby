require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
require 'bundler/setup'
Bundler.setup

require 'putio-ruby'
require 'pry'
require 'webmock/rspec'
require 'helpers'

RSpec.configure do |config|
  config.include Helpers
end

Putio.configure do |config|
  config.oauth_token = 'sometoken'
end

WebMock.disable_net_connect!(:allow => "codeclimate.com")
