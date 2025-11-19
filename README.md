# semantic_logger_datadog

**[Semantic Logger](https://logger.rocketjob.io) formatter for submitting JSON logs to [Datadog](https://www.datadoghq.com).**

[![Gem](https://img.shields.io/gem/v/semantic_logger_datadog.svg?logo=rubygems&style=for-the-badge)](https://rubygems.org/gems/semantic_logger_datadog)
[![Downloads](https://img.shields.io/gem/dt/semantic_logger_datadog.svg?logo=rubygems&style=for-the-badge)](https://rubygems.org/gems/semantic_logger_datadog)
[![Build](https://img.shields.io/github/actions/workflow/status/CargoSense/semantic_logger_datadog/ci.yml?logo=github&style=for-the-badge)](https://github.com/CargoSense/semantic_logger_datadog/actions/workflows/ci.yml)

## Installation

Add semantic_logger_datadog to your project's `Gemfile` and run `bundle install`:

```ruby
gem "semantic_logger_datadog"
```

## Usage

```ruby
require "semantic_logger_datadog"

# Set the global default log level.
SemanticLogger.default_level = :trace

# Log to a file, and use the Datadog formatter.
SemanticLogger.add_appender(file_name: "development.log", formatter: SemanticLoggerDatadog::Formatters::Json.new)

# Create an instance of a logger and add the class name to every log message.
logger = SemanticLogger["MyClass"]

# Log an info message to devleopment.log
logger.info "Hello, world!"
```

Refer to [Semantic Logger's documentation](https://logger.rocketjob.io/customize.html) for more customization options.

## Configuring Ruby on Rails

In addition to semantic_logger_datadog, add the [rails_semantic_logger](https://rubygems.org/gems/rails_semantic_logger) gem to your project's Gemfile:

```ruby
gem "rails_semantic_logger"
gem "semantic_logger_datadog"
```

The included middleware configures relevant log tags using values provided by [Action Dispatch](https://api.rubyonrails.org/classes/ActionDispatch.html).

### Adding custom controller action data

Optionally configure user-specific data in `app/controllers/application_controller.rb` by adding [an `append_info_to_payload` method](https://logger.rocketjob.io/rails.html#adding-custom-data-to-the-rails-completed-log-message):

```ruby
def append_info_to_payload(payload)
  super

  payload[:usr] = current_user.slice(:id, :name, :email) if user_signed_in?
end
```

> [!IMPORTANT]
> Be extremely careful when logging personally-identifiable information. If you aren't required to log this information for legal or regulatory reasons, don't! Your logs can't leak data they never stored in the first place.

## License

semantic_logger_datadog is freely available under the [MIT License](https://opensource.org/licenses/MIT).
