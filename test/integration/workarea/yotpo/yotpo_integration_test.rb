require 'test_helper'

module Workarea
  module Storefront
    class YotpoIntegrationTest < Workarea::IntegrationTest
      include Workarea::Storefront::IntegrationTest

      def test_js_tracking
        Workarea.with_config do |config|
          key = "YOTPO-TRACKING-APP-KEY"
          config.yotpo.app_key = key

          get storefront.root_path
          assert_includes(response.body, 'staticw2.yotpo.com/YOTPO-TRACKING-APP-KEY/widget.js')
        end
      end

      def test_product_review
        Workarea.with_config do |config|
          key = "YOTPO-TRACKING-APP-KEY"
          config.yotpo.app_key = key
          config.yotpo.show_review_summary_on_pdp = true

          get storefront.product_path(create_product)

          assert_includes(response.body, 'yotpo yotpo-main-widget')
          assert_includes(response.body, 'yotpo bottomLine')
        end
      end

      def test_order_confirmation_tracking
        Workarea.with_config do |config|
          key = "YOTPO-TRACKING-APP-KEY"
          config.yotpo.app_key = key

          complete_checkout
          follow_redirect!

          assert_includes(response.body, 'api.yotpo.com/conversion_tracking.gif')
        end
      end
    end
  end
end
