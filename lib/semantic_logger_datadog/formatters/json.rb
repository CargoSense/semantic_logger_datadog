# frozen_string_literal: true

module SemanticLoggerDatadog
  module Formatters
    class Json < Raw
      def initialize(time_format: :iso_8601, time_key: :timestamp, **args)
        super
      end

      # @return [String]
      def call(*)
        super.to_json
      end
    end
  end
end
