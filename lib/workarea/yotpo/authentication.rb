module Workarea
  module Yotpo
    module Authentication
      class NoTokenError < StandardError; end

      def token
        response = get_token
        raise NoTokenError unless response.present? && response.success?

        body = JSON.parse(response.body)
        body['access_token']
      end

      private

        def get_token
          conn = Faraday.new(url: auth_endpoint)
          conn.post do |req|
            req.url '/oauth/token', token_params
            req.headers['Content-Type'] = 'application/json'
          end
        end

        def token_params
          {
            client_id: client_id,
            client_secret: client_secret,
            grant_type: 'client_credentials'
          }
        end

        def auth_endpoint
          "https://api.yotpo.com"
        end

        def client_id
          options[:app_key]
        end

        def client_secret
          options[:secret_key]
        end
    end
  end
end
