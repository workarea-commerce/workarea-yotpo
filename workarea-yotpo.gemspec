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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://gems.weblinc.com'
  end

  spec.files = `git ls-files`.split("\n")

  spec.add_dependency 'workarea', '~> 3.x'
  spec.add_dependency 'faraday'
end
