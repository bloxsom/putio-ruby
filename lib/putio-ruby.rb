require "putio-ruby/version"

require "multi_json"
require "faraday"
require "faraday_middleware"
require "virtus"

require "putio-ruby/configuration"

require "putio-ruby/middleware/parse_root"
require "putio-ruby/middleware/oauth_token"
require "putio-ruby/middleware/error_handler"

require "putio-ruby/api/client"
require "putio-ruby/api/object"

require "putio-ruby/file"
require "putio-ruby/transfer"

require "putio-ruby/error"

module Putio
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

