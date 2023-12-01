dewu

DEWU api ruby client, based on [DEWU OPEN API](https://open.dewu.com/#/api/list?index=1)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dewu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dewu

## Usage

```bash
    # env_type: 1 => production
    # env_type: 0 => sandbox

    export DEWU_DEBUG=[app_key],[app_secret][,env_type]
```

```ruby
    require 'dewu'

    Dewu.app_key = '[app_key]'
    Dewu.app_secret = '[app_secret]'
    Dewu.base_uri = [Dewu::PRODUCTION_URL or Dewu::SANDBOX_URL]
```

```ruby
    require 'json'
    require 'dewu'

    r = Dewu::Service.auth_brand_list
    r = Dewu::Service.auth_brand_list(page_no: 1)
    r = Dewu::Service.batch_article_number('1012A910')
    r.success?
    puts JSON.pretty_generate(r)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
