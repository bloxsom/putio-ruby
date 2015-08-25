require "putio-ruby/version"

require "multi_json"
require "faraday"
require "active_support"
require "active_support/inflector"
require "active_support/core_ext/hash"

require "putio-ruby/middleware/parse"
require "putio-ruby/middleware/oauth_token"

require "putio-ruby/api/client"
require "putio-ruby/api/object"

require "putio-ruby/file"
require "putio-ruby/transfer"

require "putio-ruby/errors"

module Putio
  def self.configure(args)
    @oauth_token = args[:oauth_token]
  end

  def self.oauth_token
    @oauth_token
  end
end

