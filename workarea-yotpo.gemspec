$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "workarea/yotpo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "workarea-yotpo"
  spec.version     = Workarea::Yotpo::VERSION
  spec.authors     = ["Jeff Yucis"]
  spec.email       = ["jyucis@workarea.com"]
  spec.homepage    = "https://github.com/workarea-commerce/workarea-yotpo"
  spec.summary     = "Yotpo User Generated Content for Workarea Ecommerce."
  spec.description = "Reviews and order syncing for YotPo"

  spec.files = `git ls-files`.split("\n")

  spec.add_dependency 'workarea', '~> 3.x'
  spec.add_dependency 'faraday'
end
