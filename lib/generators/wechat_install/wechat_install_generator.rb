class WechatInstallGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  desc "This generator creates an wechat and redis config file at config/"

  def copy_initializer_file
    copy_file "redis.yml", "config/redis.yml"
    copy_file "wechat.yml", "config/wechat.yml"
  end
end
