$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "wechat/access_token/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "wechat-access_token"
  spec.version     = Wechat::AccessToken::VERSION
  spec.authors     = ["beslow"]
  spec.email       = ["549174542@qq.com"]
  spec.homepage    = "https://github.com/beslow/wechat-access_token"
  spec.summary     = "微信公众号开发，获取access_token"
  spec.description = "微信公众号开发，通过简单配置，获取access_token。"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.2.4", ">= 5.2.4.1"
  spec.add_dependency "hashie", '~> 4.1'
  spec.add_dependency "redis", '~> 4.1', '>= 4.1.3'
  spec.add_dependency 'rest-client', '~> 2.1'
  spec.add_development_dependency "sqlite3", '~> 0'
  spec.add_development_dependency "rspec-rails", '~> 0'
end
