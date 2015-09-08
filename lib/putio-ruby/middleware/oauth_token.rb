module Putio
  module Middleware
    class OauthToken < Faraday::Response::Middleware
      def call(env)
        raise Putio::ApplicationCredentialsRequired, "No OAuth token provided" unless Putio.configuration.oauth_token
        oauth_string = "oauth_token=#{Putio.configuration.oauth_token}"
        query = env[:url].query
        env[:url].query = query ? "#{query}&#{oauth_string}" : oauth_string
        @app.call(env)
      end
    end
  end
end
