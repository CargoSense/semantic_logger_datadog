# frozen_string_literal: true

begin
  require "rails_semantic_logger"
rescue LoadError => e
  raise %(semantic_logger_datadog: Install the rails_semantic_logger gem to continue. (#{e}))
end

require_relative "middleware"

module SemanticLoggerDatadog
  class Railtie < Rails::Railtie
    # Log to standard output when +RAILS_LOG_TO_STDOUT+ is configured.
    #
    # @see https://logger.reidmorrison.com/rails.html#output-formats
    # @see https://logger.reidmorrison.com/rails.html#production-on-a-container-platform-docker-kubernetes-heroku
    if ENV["RAILS_LOG_TO_STDOUT"].present?
      config.rails_semantic_logger.appenders do |appenders|
        appenders.add(formatter: SemanticLoggerDatadog::Formatters::Json.new, io: $stdout)
      end
    end

    initializer "semantic_logger_datadog.configure_rails_initialization" do |app|
      # Set application name.
      app.config.semantic_logger.application = Rails.application.name

      # Set backtrace level to avoid memory leaks due to high object allocation.
      #
      # @see https://logger.reidmorrison.com/rails.html#source-file-name-and-line-number
      app.config.semantic_logger.backtrace_level = :error if Rails.env.production?

      app.middleware.insert_before RailsSemanticLogger::Rack::Logger, SemanticLoggerDatadog::Middleware
    end
  end
end
