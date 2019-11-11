module Workarea
  module Yotpo
    class BogusGateway

      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def create_order(order_details)
        Response.new(response)
      end

      private
        def response
          response = Faraday.new do |builder|
            builder.adapter :test do |stub|
              stub.get('/rest/bogus.json') { |env| [ 200, {}, response_body ] }
            end
          end
          response.get('/rest/bogus.json')
        end

        def response_body
          {
            code: 200,
            message: "OK",
            uuid: "4161933d-9213-45ee-beb4-cb3ac2844345"
          }.to_json
        end
    end
  end
end
