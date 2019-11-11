Workarea.configure do |config|
  config.yotpo = ActiveSupport::Configurable::Configuration.new
  config.yotpo.app_key = nil # js sdk integration

  # show review summary on PDP
  config.yotpo.show_review_summary_on_pdp = true

  # show review summaries on product summaries in search,
  # browse, and recomendation
  config.yotpo.show_review_summary_on_product_summary = true
end
