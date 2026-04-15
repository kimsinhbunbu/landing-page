require_relative "boot"
require "logger"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LandingPage
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0


    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

# Hack for CentOS 7 (SQLite 3.7.17 < 3.8)
ActiveSupport.on_load(:active_record) do
  require 'active_record/connection_adapters/sqlite3_adapter'
  class ActiveRecord::ConnectionAdapters::SQLite3Adapter
    def check_version(*args); end
  end
end
