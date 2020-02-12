# Wechat::AccessToken
微信公众号 access_token获取

## Usage
After Installation,
genearte wechat.yml and redis.yml and config them 
```bash
rails generate wechat_install_config
```

then you can get access_token by
```ruby
Wechat::AccessToken.current
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'wechat-access_token'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install wechat-access_token
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
