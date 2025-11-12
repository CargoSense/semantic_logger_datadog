# frozen_string_literal: true

module SemanticLoggerDatadog
  module Formatters
    class Raw < SemanticLogger::Formatters::Raw
      # @return [Hash]
      def call(*)
        super

        request_id
        dd_hash
        http_hash
        logger_hash
        usr_hash

        hash
      end

      # @return [Hash{Symbol => String}, nil]
      def dd_hash
        hash[:dd] = log.named_tags.delete(:dd)
      end

      # @return [String, nil]
      def duration
        return unless log.duration

        # Convert milliseconds to nanoseconds
        hash[:duration] = log.duration * 1_000_000
        hash[:duration_human] = log.duration_human
      end

      # @return [Hash]
      def exception
        return unless log.exception

        kind = log.exception.class.name
        message = log.exception.message
        stack = log.backtrace_to_s

        hash.merge!(
          error: { kind:, message:, stack: }.compact,
          message: [kind, message].compact.join(": ")
        )
      end

      # @return [Hash{Symbol => Hash{Symbol => String}}]
      def http_hash
        method, status_code = [:method, :status].map { |key| log.payload&.delete(key) }
        remote_ip, url, useragent = [:remote_ip, :url, :useragent].map { |key| log.named_tags.delete(key) }

        http = { method:, remote_ip:, status_code:, url:, useragent: }

        http.compact!

        hash[:http] = http unless http.empty?
      end

      # @return [Hash{Symbol => String}]
      def logger_hash
        hash[:logger] = {
          name: logger.name,
          thread_name: log.thread_name,
        }
      end

      # @return [String]
      def request_id
        hash[:request_id] = log.named_tags.delete(:request_id)
      end

      # @return [Hash{Symbol => Integer, String}, nil]
      def usr_hash
        hash[:usr] = log.payload&.delete(:usr)
      end
    end
  end
end
