require 'workarea/testing/teaspoon'

Teaspoon.configure do |config|
  config.root = Workarea::Yotpo::Engine.root
  Workarea::Teaspoon.apply(config)
end
