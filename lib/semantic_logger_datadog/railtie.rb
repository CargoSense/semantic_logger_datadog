# frozen_string_literal: true

begin
  require "rails_semantic_logger"
rescue LoadError => e
  raise %(semantic_logger_datadog: Install the rails_semantic_logger gem to continue. (#{e}))
end

module SemanticLoggerDatadog
  class Railtie < Rails::Railtie
    # Set log output format.
    #
    # @see https://logger.rocketjob.io/rails.html#output-format
    config.rails_semantic_logger.format = SemanticLoggerDatadog::Formatters::Json.new

    # Set backtrace level to avoid memory leaks due to high object allocation.
    #
    # @see https://logger.rocketjob.io/rails.html#include-the-file-name-and-line-number-in-the-source-code-where-the-message-originated
    config.semantic_logger.backtrace_level = :error if Rails.env.production?

    # Log to standard output when +RAILS_LOG_TO_STDOUT+ is configured.
    #
    # @see https://logger.rocketjob.io/rails.html#log-to-standard-out
    if ENV["RAILS_LOG_TO_STDOUT"].present?
      $stdout.sync = true
      config.rails_semantic_logger.add_file_appender = false
      config.semantic_logger.add_appender(formatter: config.rails_semantic_logger.format, io: $stdout)
    end
  end
end
