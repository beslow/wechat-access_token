module Wechat
  def self.config
    @config ||= begin
      path = ::Rails.root.join("config/wechat.yml")

      raise StandardError, '请先在config文件夹下配置wechat.yml' unless File.exists?(path)

      result = YAML::load(ERB.new(IO.read(path)).result) rescue {}

      result = Hashie::Mash.new(result)

      if result.base.nil? || result.base.appid.nil? || result.base.appsecret.nil?
        raise StandardError, "wechat.yml文件配置错误"
      end

      result
    end
  end

  def self.redis
    @redis ||= begin
      path = ::Rails.root.join("config/redis.yml")

      raise StandardError, '请先在config文件夹下配置redis.yml' unless File.exists?(path)

      result = YAML::load(ERB.new(IO.read(path)).result) #rescue {}

      result = result[Rails.env]

      raise StandardError, "redis.yml文件配置错误" if result.nil?

      result = Hashie::Mash.new(result)

      if result.host.nil? || result.port.nil? || result.wechat_db.nil?
        raise StandardError, "redis.yml文件配置错误"
      end

      Redis.new(host: result.host, password: result.password, port: result.port, db: result.wechat_db)
    end
  end

  def self.clear_redis
    @redis = nil
  end

  def self.clear_config
    @config = nil
  end
end