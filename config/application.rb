require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Dissertation
  class Application < Rails::Application
    config.time_zone = 'Novosibirsk'
    config.i18n.default_locale = :ru
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
