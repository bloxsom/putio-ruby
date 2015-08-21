require "putio/version"

require "multi_json"
require "faraday"
require "active_support"
require "active_support/inflector"
require "active_support/core_ext/hash"

require "putio/middleware/parse"
require "putio/middleware/oauth_token"

require "putio/api/client"
require "putio/api/object"

require "putio/file"
require "putio/transfer"

require "putio/errors"

module Putio
  def self.configure(args)
    @oauth_token = args[:oauth_token]
  end

  def self.oauth_token
    @oauth_token
  end
end

