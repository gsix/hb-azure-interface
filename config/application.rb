require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module HbAzureInterface
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.i18n.locale = :ru
    config.load_defaults 5.2
    config.autoload_paths << Rails.root.join('lib')
    config.hb_azure_interface = OpenStruct.new config_for(:hb_azure_interface).deep_symbolize_keys
  end
end
