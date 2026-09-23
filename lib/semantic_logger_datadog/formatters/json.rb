# frozen_string_literal: true

module SemanticLoggerDatadog
  module Formatters
    class Json < Raw
      def initialize(time_format: :iso_8601, time_key: :timestamp, **args)
        super
      end

      # Returns log messages in JSON format.
      #
      # @return [String]
      def call(*)
        SemanticLogger::Utils.to_json(super)
      end

      # Returns a batch of log messages as a JSON array.
      #
      # @return [String]
      def batch(logs, logger)
        "[#{logs.map { |log| call(log, logger) }.join(",")}]"
      end
    end
  end
end
