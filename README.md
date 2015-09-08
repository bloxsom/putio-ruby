[![Gem Version](https://badge.fury.io/rb/putio-ruby.svg)](http://badge.fury.io/rb/putio-ruby)
[![Build Status](https://travis-ci.org/bloxsom/putio-ruby.svg?branch=master)](https://travis-ci.org/bloxsom/putio-ruby)
[![Code Climate](https://codeclimate.com/github/bloxsom/putio-ruby/badges/gpa.svg)](https://codeclimate.com/github/bloxsom/putio-ruby)
[![Test Coverage](https://codeclimate.com/github/bloxsom/putio-ruby/badges/coverage.svg)](https://codeclimate.com/github/bloxsom/putio-ruby/coverage)

putio-ruby is a simple gem for communicating with the Put.io REST API. Currently supports just a handful of endpoints for Files and Transfers.


## Installation

Add the gem to your Gemfile:

```ruby
gem 'putio-ruby'
```

And then

    $ bundle install

Or install it yourself as:

    $ gem install putio-ruby

## Usage

First configure the gem to use your oauth token (See [instructions](https://put.io/v2/docs/gettingstarted.html#sign-up) for generating a token)

```ruby
Putio.configure do |config|
  oauth_token = "YOUR_OAUTH_TOKEN"
end
```

Then use it to query Put.io

```ruby
Putio::File.list              # => [#<Putio::File:0x007fe1b3a84d40, ...]
file = Putio::File.get(1234)  # => #<Putio::File:0x007fe373b07558
file.download_url             # => "https://dlw3.put.io/download/12345..."
file.delete                   # => true

Putio::Transfer.list                        # => [#<Putio::Transfer:0x007fe373a80580, ...]
Putio::Transfer.get(1234)                   # => #<Putio::Transfer:0x007fe373a9afc0
Putio::Transfer.add("http://some_url.com")  # => #<Putio::Transfer:0x007fe373aa2c70
```
