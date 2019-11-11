require 'test_helper'

module Workarea
  module Yotpo
    class OrderTest < Workarea::TestCase
      def test_to_h
        _order_total_discount = create_order_total_discount(order_total: 1.to_m)
        order = create_placed_order

        hash = Order.new(order.id).to_h

        assert_equal(order.total_price.currency.iso_code, hash[:currency_iso])
        assert_equal(order.email, hash[:email])
        assert_equal(order.id, hash[:order_id])

        item = Workarea::Storefront::OrderItemViewModel.new(order.items.first)
        hash_product = hash[:products][item.product_id]

        assert(hash[:products][item.product_id].present?)
        assert_equal(hash_product[:description], item.product.description)
        assert_equal(hash_product[:name], item.product.name)
        assert_equal(hash_product[:price], item.original_price.to_s)
      end

      private

      def create_placed_order(overrides = {})
        attributes = factory_defaults(:placed_order).merge(overrides)

        shipping_service = create_shipping_service
        sku = 'SKU'
        create_product(description: "test description", variants: [{ sku: sku, regular: 5.to_m }])
        details = OrderItemDetails.find(sku)
        order = Workarea::Order.new(attributes)
        item = { sku: sku, quantity: 2 }.merge(details.to_h)

        order.add_item(item)

        checkout = Checkout.new(order)
        checkout.update(
          factory_defaults(:checkout_payment).merge(
            shipping_address: factory_defaults(:shipping_address),
            billing_address: factory_defaults(:billing_address),
            shipping_service: shipping_service.name,
          )
        )

        unless checkout.place_order
          raise(
            UnplacedOrderError,
            'failed placing the order in the create_placed_order factory'
          )
        end

        forced_attrs = overrides.slice(:placed_at, :update_at, :total_price)
        order.update_attributes!(forced_attrs)
        order
      end
    end
  end
end
