module Workarea
  module Yotpo
    class Order
       module ProductUrl
        include Workarea::I18n::DefaultUrlOptions
        include Storefront::Engine.routes.url_helpers
        extend self
      end

      module ProductImageUrl
        include Workarea::ApplicationHelper
        include Workarea::I18n::DefaultUrlOptions
        include ActionView::Helpers::AssetUrlHelper
        include Core::Engine.routes.url_helpers
        extend self

        def mounted_core
          self
        end
      end

      attr_reader :order_id, :options

      def initialize(order_id, options = {})
        @order_id = order_id
        @options = options
      end

      # Builds an order hash for Yotpo
      # API consumption
      #
      # @return [Hash]
      def to_h
        {
          validate_data: true,
          platform: "general", # TODO - get on the list of approved yotpo platforms
          email: order.email,
          customer_name: order.billing_address.first_name + " " + order.billing_address.last_name,
          order_id: order.id,
          order_date: order.placed_at,
          currency_iso: order.total_price.currency.iso_code,
          products: products,
          customer: customer
        }
      end

      private

        def order
          @order ||=
            begin
              o = Workarea::Order.find(order_id)
                Workarea::Storefront::OrderViewModel.new(o)
            end
        end

        # @return [Hash]
        def products
          order.items.inject({}) do |memo, item|
            memo[item.product.id] = {
              url: ProductUrl.product_url(id: item.product.to_param, host: Workarea.config.host),
              name: item.product.name,
              description: item.product.description,
              price: item.original_price.to_s,
              image: ProductImageUrl.product_image_url(item.image, :detail)
            }
            memo
          end
        end

        def customer
          address = order.shipping_address || order.billing_address
          {
            state: address.region,
            country: address.country.alpha2,
            address: address.street
          }
        end
    end
  end
end
