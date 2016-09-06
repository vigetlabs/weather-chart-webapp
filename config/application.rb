require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Weatherchart
  class Application < Rails::Application
    config.secret_key_base = ENV["SECRET_KEY_BASE"]

    config.time_zone = 'Mountain Time (US & Canada)'

    config.autoload_paths += %W(#{config.root}/lib/weatherchart)

    config.generators do |g|
      g.assets false
      g.helper false
    end

    config.active_record.raise_in_transactional_callbacks = true
  end
end
