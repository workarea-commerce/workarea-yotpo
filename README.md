Workarea Yotpo
================================================================================

Yotpo plugin for the Workarea platform.

The following features are supported:

  * Yotpo JS SDK included on every page
  * Order tracking JS on confirmation page
  * Order export via the API
  * Review display on PDP and product summaries.

Configuration
--------------------------------------------------------------------------------

An app key must be set in configuration to enable reviews.

Add the following to an initializer:

    config.yotpo.app_key = nil

A secret must be provided in the secrets to send orders via the API.

Add the following to secrets:

    yotpo:
      secret_key: YOUR-SECRET-KEY

Additional configuration options are available for displaying reviews:

    # show review summary on PDP
    config.yotpo.show_review_summary_on_pdp = true #

    # show review summaries on product summaries in search,
    # browse, and recommendations
    config.yotpo.show_review_summary_on_product_summary = true

    config.curalate.site_name = 'YOUR_SITE_NAME'


Getting Started
--------------------------------------------------------------------------------

This gem contains a rails engine that must be mounted onto a host Rails application.

To access Workarea gems and source code, you must be an employee or a licensed retailer or partner.

Workarea gems are hosted privately at https://gems.weblinc.com/.
You must have individual or team credentials to install gems from this server. Add your gems server credentials to Bundler:

    bundle config gems.weblinc.com my_username:my_password

Or set the appropriate environment variable in a shell startup file:

    export BUNDLE_GEMS__WEBLINC__COM='my_username:my_password'

Then add the gem to your application's Gemfile specifying the source:

    # ...
    gem 'workarea-yotpo', source: 'https://gems.weblinc.com'
    # ...

Or use a source block:

    # ...
    source 'https://gems.weblinc.com' do
      gem 'workarea-yotpo'
    end
    # ...

Update your application's bundle.

    cd path/to/application
    bundle

Workarea Platform Documentation
--------------------------------------------------------------------------------

See [http://developer.workarea.com](http://developer.workarea.com) for Workarea platform documentation.

Copyright & Licensing
--------------------------------------------------------------------------------

Copyright Workarea 2019. All rights reserved.

For licensing, contact sales@workarea.com.
