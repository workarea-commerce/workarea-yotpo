module Workarea
  module Yotpo
    class SaveOrder
      include Sidekiq::Worker
      include Sidekiq::CallbacksWorker

      sidekiq_options(
        enqueue_on: { Workarea::Order => [:place] },
        unique: :until_executing
      )

      def perform(id)
        order = Workarea::Order.find(id)
        yotpo_order = Workarea::Yotpo::Order.new(order.id)

        Workarea::Yotpo.gateway.create_order(yotpo_order.to_h)
      end
    end
  end
end
