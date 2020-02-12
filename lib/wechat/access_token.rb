require "rails"
require "hashie"
require 'redis'
require "rest-client"

require "wechat/access_token/railtie"
require "wechat/config"
module Wechat
  module AccessToken
    def self.key
      'wechat-access-token'
    end

    def self.current
      Wechat.redis.get(key) || get_new
    end

    def self.request
      url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Wechat.config.base.appid}&secret=#{Wechat.config.base.appsecret}"
      response = ::RestClient.get(url)
      JSON.parse(response)
    end

    def self.get_new
      response = request

      code = response['errcode']

      raise StandardError, response['errmsg'] if [-1, 40001, 40164, 40002, 40013].include?(code)

      token = response['access_token']
      if token.present?
        Wechat.redis.set(key, token, ex: response['expires_in'].to_i - 5 * 60)
        token
      else
        result
      end
    end
  end
end
