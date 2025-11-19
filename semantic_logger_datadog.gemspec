# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= 3.1"

  spec.name          = "semantic_logger_datadog"
  spec.version       = "0.2.0"
  spec.authors       = ["CargoSense"]
  spec.email         = ["rubygems@cargosense.com"]

  spec.summary       = "Semantic Logger formatter for submitting JSON logs to Datadog."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/CargoSense/semantic_logger_datadog"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"].reject { |f| File.directory?(f) }
  spec.files        += ["LICENSE", "README.md"]
  spec.files        += ["semantic_logger_datadog.gemspec"]

  spec.require_paths = ["lib"]

  spec.metadata = {
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/releases",
    "documentation_uri" => "https://rubydoc.info/gems/#{spec.name}/#{spec.version}",
    "homepage_uri" => spec.homepage,
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "#{spec.homepage}/tree/v#{spec.version}",
  }

  spec.add_dependency "semantic_logger", "~> 4.17"
end
