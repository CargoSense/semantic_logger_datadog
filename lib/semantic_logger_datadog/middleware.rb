# frozen_string_literal: true

module SemanticLoggerDatadog
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = ActionDispatch::Request.new(env)

      hash = {
        remote_ip: request.remote_ip,
        request_id: request.request_id,
        url: request.original_url,
        useragent: request.headers["user-agent"],
      }

      SemanticLogger.named_tagged(hash) { @app.call(env) }
    end
  end
end
