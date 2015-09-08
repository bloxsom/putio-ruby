module Putio
  module Middleware
    class ErrorHandler < Faraday::Response::Middleware
      def on_complete(env)
        raise Putio::Error.from_env(env) if env.status >= 400
      end
    end
  end
end
