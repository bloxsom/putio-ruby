module Putio
  module Middleware
    class ParseRoot < Faraday::Response::Middleware
      def on_complete(env)
        headers = env[:response_headers] ? env[:response_headers] : nil
        return unless headers["content-type"] && headers["content-type"].include?("json")
        plural = env.url.to_s.match(/api\.put\.io\/v2\/(\w+)\//)[1]
        singular = plural[0..-2]
        if env[:body][plural]
          env[:body] = env[:body][plural]
        elsif env[:body][singular]
          env[:body] = env[:body][singular]
        end
      end
    end
  end
end
