Workarea.append_partials(
  'storefront.document_head',
  'workarea/storefront/yotpo_tracking'
)

Workarea.append_partials(
  'storefront.product_show',
  'workarea/storefront/products/yotpo_reviews'
)

Workarea.append_partials(
  'storefront.product_details',
  'workarea/storefront/products/yotpo_product_summary'
)

Workarea.append_partials(
  'storefront.product_summary',
  'workarea/storefront/products/yotpo_summary'
)

Workarea.append_partials(
  'storefront.checkout_confirmation',
  'workarea/storefront/checkouts/yotpo_order_tracking'
)
