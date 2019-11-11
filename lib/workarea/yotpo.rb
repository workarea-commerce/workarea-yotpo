require 'workarea'
require 'workarea/storefront'
require 'workarea/admin'

require 'workarea/yotpo/engine'
require 'workarea/yotpo/version'

require 'workarea/yotpo/authentication'
require 'workarea/yotpo/gateway'
require 'workarea/yotpo/bogus_gateway'
require 'workarea/yotpo/response'

require 'faraday'

module Workarea
  module Yotpo
    def self.credentials
      (Rails.application.secrets.yotpo || {}).deep_symbolize_keys
    end

    def self.config
      Workarea.config.yotpo
    end

    def self.app_key
      config.app_key
    end

    def self.secret_key
      credentials[:secret_key]
    end

    def self.gateway
      if credentials.present?
        Workarea::Yotpo::Gateway.new(app_key: app_key, secret_key: secret_key)
      else
        Workarea::Yotpo::BogusGateway.new
      end
    end
  end
end
