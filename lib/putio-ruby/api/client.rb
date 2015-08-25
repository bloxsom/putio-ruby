module Putio
  module Api
    module Client
      def client
        @client ||= Faraday.new :url => "https://api.put.io/v2/" do |connection|
          # Request
          connection.use Putio::Middleware::OauthToken
          connection.request :url_encoded

          # Response
          connection.use Putio::Middleware::Parse
          connection.adapter :net_http
        end
      end
    end
  end
end
