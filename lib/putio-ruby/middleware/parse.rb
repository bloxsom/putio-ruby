module Putio
  module Middleware
    class Parse < Faraday::Response::Middleware
      def parse(body)
        begin
          return MultiJson.load(body, :symbolize_keys => true)
        rescue MultiJson::ParseError
          return body
        end
      end

      def on_complete(env)
        env[:body] = parse(env[:body])
      end
    end
  end
end
