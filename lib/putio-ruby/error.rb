module Putio
  class Error < StandardError
    def self.from_env(env)
      status = env.status

      if klass = case status
                 when 400..499  then Putio::BadRequest
                 when 500..599  then Putio::ServerError
                 end
        klass.new(env)
      end
    end

    def initialize(env=nil)
      @env = env
      super(build_error_message)
    end

    def response_error
      if response_body && error_type && error_message
        "#{error_type}: #{error_message}"
      elsif response_body && error_message
        error_message
      else
        response_body
      end
    end

    def build_error_message
      return nil if @env.nil?

      message =  "#{@env.method.to_s.upcase} "
      message << "#{@env.status} - #{@env.url}\n"
      message << "#{response_error}" unless response_error.nil?
      message
    end

    def response_headers
      @env.response_headers
    end

    def response_status
      @env.status
    end

    def response_body
      @env.body
    end

    def error_type
      @env.body["error_type"]
    end

    def error_message
      @env.body["error_message"]
    end
  end

  class BadRequest < Error; end
  class ServerError < Error; end
  class ApplicationCredentialsRequired < StandardError; end
end
