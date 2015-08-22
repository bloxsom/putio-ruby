# putio-ruby

[![Gem Version](https://badge.fury.io/rb/putio-ruby.svg)](http://badge.fury.io/rb/putio-ruby)
[![Build Status](https://travis-ci.org/bloxsom/putio-ruby.svg?branch=master)](https://travis-ci.org/bloxsom/putio-ruby)
[![Code Climate](https://codeclimate.com/github/bloxsom/putio-ruby/badges/gpa.svg)](https://codeclimate.com/github/bloxsom/putio-ruby)
[![Test Coverage](https://codeclimate.com/github/bloxsom/putio-ruby/badges/coverage.svg)](https://codeclimate.com/github/bloxsom/putio-ruby/coverage)

putio-ruby is a simple gem for communicating with the Put.io REST API. Currently supports just a handful of endpoints for Files and Transfers.


## Installation

Add the gem to your Gemfile:

```
gem 'putio-ruby'
```

And then

    $ bundle install

Or install it yourself as:

    $ gem install putio-ruby

## Usage

First configure the gem to use your oauth token (See [instructions](https://put.io/v2/docs/gettingstarted.html#sign-up) for generating a token)

	Putio.configure :oauth_token => YOUR_OAUTH_TOKEN
	
Then use it to query Put.io

	Putio::File.list
	Putio::File.get(1234)
	Putio::File.get(1234).delete
	Putio::File.get(1234).download_url
	
	Putio::Transfer.list
	Putio::Transfer.get(1234)
	Putio::Transfer.add("http://some_url.com")



## Contributing

1. Fork it ( https://github.com/[my-github-username]/putio-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
