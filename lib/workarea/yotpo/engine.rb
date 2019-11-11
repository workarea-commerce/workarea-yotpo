require 'workarea/yotpo'

module Workarea
  module Yotpo
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::Yotpo
    end
  end
end
