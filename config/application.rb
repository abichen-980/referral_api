require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReferralApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    config.middleware.use ActionDispatch::Session::CookieStore, key: "_referrals_api_session"

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # skipping few file generation for rspec.
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,    # Disable view specs
                       helper_specs: false,  # Disable helper specs
                       routing_specs: false, # Disable routing specs
                       controller_specs: false, # Disable controller specs
                       request_specs: true   # Enable request specs

      g.fixture_replacement :factory_bot, dir: "spec/factories" # Use FactoryBot for fixtures
    end
  end
end