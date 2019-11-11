require 'test_helper'

module Workarea
  class Yotpo::SaveOrderTest < TestCase
    def test_order_yotpo_save_order
      order = create_placed_order

      response = Workarea::Yotpo::SaveOrder.new.perform(order.id)

      assert_instance_of(Workarea::Yotpo::Response, response)
    end
  end
end
