module Putio
  module Api
    module Client
      def client
        Faraday.new :url => "https://api.put.io/v2/" do |connection|
          # Request
          connection.request :url_encoded
          connection.use Putio::Middleware::OauthToken

          # Response
          connection.use Putio::Middleware::ParseRoot
          connection.use Putio::Middleware::ErrorHandler
          connection.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/

          # Adapter
          connection.adapter :typhoeus
        end
      end
    end
  end
end
