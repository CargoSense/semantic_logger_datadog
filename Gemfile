# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in semantic_logger_datadog.gemspec
gemspec

gem "rake"
gem "rubocop-cargosense"
gem "rubocop-packaging"

local_gemfile = File.expand_path("Gemfile.local", __dir__)
eval_gemfile local_gemfile if File.exist?(local_gemfile)
