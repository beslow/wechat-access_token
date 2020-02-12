RSpec.describe "Wechat::AccessToken redis config", :right_config, :right_redis_config do
  let(:config_path) { ::Rails.root.join("config/redis.yml") }

  it "should raise error if not set redis.yml" do
    File.delete(config_path) if File.exists?(config_path)
    expect { Wechat.redis }.to raise_error(/请先在config文件夹下配置redis\.yml/)
  end

  it "should raise error if not set correctly in config" do
    File.open(config_path, "w+") do |f|
      f.syswrite("default:\n")
      f.syswrite("  host: local\n")
      f.syswrite("  password: \n")
      f.close
    end
    expect { Wechat.redis }.to raise_error(/redis\.yml文件配置错误/)
  end

  it "enable to set and get key" do
    expect(Wechat.redis.set('a', 1)).to eq('OK')
    Wechat.redis.set('b', 2)
    expect(Wechat.redis.get('b')).to eq('2')
  end

  it "should read file once in many access" do
    allow(Redis).to receive(:new).and_return(Redis.new(host: 'localhost'))
    Wechat.redis
    Wechat.redis
    expect(Redis).to have_received(:new).once
  end
end