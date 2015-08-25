module Putio
  module Middleware
    class OauthToken < Faraday::Response::Middleware
      def call(env)
        raise Putio::Errors::AuthorizationError, "No OAuth token provided" unless Putio.oauth_token
        oauth_string = "oauth_token=#{Putio.oauth_token}"
        query = env[:url].query
        env[:url].query = query ? "#{query}&#{oauth_string}" : oauth_string
        @app.call(env)
      end
    end
  end
end
