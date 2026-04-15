require "logger"
require "yaml"
require "psych"

# Patch Psych to allow aliases (needed for Ruby 2.7.2+ and Rails 6 database.yml)
module Psych
  class << self
    alias_method :orig_load, :load rescue nil
    if method_defined?(:orig_load)
      def load(yaml, **options)
        orig_load(yaml, aliases: true, **options)
      end
    end
  end
end

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

# Hack for CentOS 7 (SQLite 3.7.17 < 3.8)
begin
  require 'active_record/connection_adapters/sqlite3_adapter'
  module ActiveRecord
    module ConnectionAdapters
      class SQLite3Adapter
        private
        def check_version(connection); end
      end
    end
  end
rescue LoadError
end
