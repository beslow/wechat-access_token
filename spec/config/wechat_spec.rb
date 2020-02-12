RSpec.describe "Wechat::AccessToken wechat config" do
  let(:config_path) { ::Rails.root.join("config/wechat.yml") }

  after(:example) do
    File.delete(config_path) if File.exists?(config_path)
    Wechat.clear_config
  end

  it "should raise error if not set wechat.yml" do
    File.delete(config_path) if File.exists?(config_path)
    expect { Wechat.config.base.appid }.to raise_error(/请先在config文件夹下配置wechat\.yml/)
  end

  it "should raise error if not set base in config" do
    File.open(config_path, "w+") do |f|
      f.syswrite("aa:\n")
      f.syswrite("  appid: 123\n")
      f.syswrite("  appsecret: 456\n")
      f.close
    end
    expect { Wechat.config.base.appid }.to raise_error(/wechat\.yml文件配置错误/)
  end

  it "should raise error if not set appid in config" do
    File.open(config_path, "w+") do |f|
      f.syswrite("base:\n")
      f.syswrite("  appsecret: 456\n")
      f.close
    end
    expect { Wechat.config.base.appid }.to raise_error(/wechat\.yml文件配置错误/)
  end

  it "should raise error if not set appsecret in config" do
    File.open(config_path, "w+") do |f|
      f.syswrite("base:\n")
      f.syswrite("  appid: 123\n")
      f.close
    end
    expect { Wechat.config.base.appid }.to raise_error(/wechat\.yml文件配置错误/)
  end

  it "enabled to access appid and appsecret with config", :right_config do
    expect(Wechat.config.base.appid.to_s).to eq("123")
    expect(Wechat.config.base.appsecret.to_s).to eq("456")
  end

  it "should read file once in many access", :right_config do
    allow(Hashie::Mash).to receive(:new).and_return(Hashie::Mash.new({base: {appid: 1, appsecret: 2}}))
    Wechat.config
    Wechat.config
    expect(Hashie::Mash).to have_received(:new).once
  end
end