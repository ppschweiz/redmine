# Settings specified here will take precedence over those in config/environment.rb

# The stage environment is meant for integration testing.
# Code is not reloaded between requests
config.cache_classes = true

# Show full error reports and caching is turned on
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = true

# Disable delivery errors if you bad email addresses should just be ignored
config.action_mailer.raise_delivery_errors = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils        = true

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

