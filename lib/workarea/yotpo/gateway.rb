module Workarea
  module Yotpo
    class Gateway
      include Yotpo::Authentication
      class YotpoGatewayError < StandardError; end

      attr_reader :options

      def initialize(options = {})
        requires!(options, :app_key, :secret_key)
        @options = options
      end

      def create_order(order_details)
        auth_creds = {
          utoken: token,
          app_key: client_id
        }

        body = order_details.merge(auth_creds).to_json

        response = connection.post do |req|
          req.url "apps/#{client_id}/purchases/"
          req.body = body
        end

        Response.new(response)
      end

      private

        def rest_endpoint
          'https://api.yotpo.com'
        end

        def connection
          headers = {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{token}"
          }

          request_timeouts = {
            timeout: Workarea.config.yotpo.api_timeout,
            open_timeout: Workarea.config.yotpo.open_timeout
          }

          Faraday.new(url: rest_endpoint, headers: headers, request: request_timeouts)
        end

        def requires!(hash, *params)
          params.each do |param|
            if param.is_a?(Array)
              raise ArgumentError.new("Missing required parameter: #{param.first}") unless hash.has_key?(param.first)

              valid_options = param[1..-1]
              raise ArgumentError.new("Parameter: #{param.first} must be one of #{valid_options.to_sentence(words_connector: 'or')}") unless valid_options.include?(hash[param.first])
            else
              raise ArgumentError.new("Missing required parameter: #{param}") unless hash.has_key?(param)
            end
          end
        end
    end
  end
end
