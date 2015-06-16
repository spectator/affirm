[![Build Status](https://travis-ci.org/spectator/affirm.svg?branch=master)](http://travis-ci.org/spectator/affirm)
[![Code Climate](https://codeclimate.com/github/spectator/affirm/badges/gpa.svg)](https://codeclimate.com/github/spectator/affirm)

# Affirm

Affirm gem is a simple Ruby wrapper for Affirm.com API. Please check Affirm API
[documentation](http://docs.affirm.com/v2/api/#sandbox-api-keys) for more
details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'affirm-ruby', require: 'affirm'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install affirm-ruby

## Configuration

```ruby
Affirm.configure do |config|
  config.public_api_key  = "ABC"
  config.private_api_key = "XYZ"
  config.environment     = :sandbox # or :production (default if not specified)
end
```

## Usage

To authorize a charge `checkout_token` is required. This token gets `POST`ed to
`user_confirmation_url` that is setup in Checkout JavaScript object.

```ruby
Affirm::Charge.authorize(checkout_token)
```

The rest of the API uses `charge_id` which is received as `id` after charge is
authorized.

#### Read charge

```ruby
Affirm::Charge.find("TEST-AL04-UVGR")
```

#### Capture charge

```ruby
Affirm::Charge.capture("TEST-ALO4-UVGR")
```

#### Void charge

```ruby
Affirm::Charge.void("TEST-ALO4-UVGR")
```

#### Refund charge

```ruby
Affirm::Charge.refund("TEST-ALO4-UVGR", amount: 500)
```

#### Update charge

```ruby
Affirm::Charge.update("TEST-ALO4-UVGR",
  order_id: "CUSTOM_ORDER_ID",
  shipping_carrier: "USPS",
  shipping_confirmation: "1Z23223"
)
```

Failed response will return [error
object](http://docs.affirm.com/v2/api/errors/#error-object) as a plain ruby
object with values coerced in corresponding types.

The same will happen for all successful responses described (not in full) in
[server integration](http://docs.affirm.com/v2/api/charges/#authentication)
guide.

#### Example

```ruby
response = Affirm::Charge.authorize(checkout_token)
if response.success?
  charge_id = response.id
  # save charge_id
else
  puts response.error.message
end
```

## Contributing

1. Fork it ( https://github.com/spectator/affirm/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
