Rails.application.config.active_record.sqlite3.represent_boolean_as_integer = true

RSpec.describe "Wechat::AccessToken request", :right_redis_config, :right_config do
  it "raise error with wrong appid" do
    allow(Wechat::AccessToken).to receive(:request).and_return({"errcode" => 40013, "errmsg" => "invalid appid"})
    expect { Wechat::AccessToken.get_new }.to raise_error(/invalid appid/)
  end

  it "return token with right config" do
    allow(Wechat::AccessToken).to receive(:request).and_return({"access_token" => "ACCESS_TOKEN", "expires_in" => 7200})
    expect(Wechat::AccessToken.get_new).to eq("ACCESS_TOKEN")
  end

  it "should request once in expires_in seconds" do
    allow(Wechat::AccessToken).to receive(:request).and_return({"access_token" => "ACCESS_TOKEN", "expires_in" => 7200})
    Wechat::AccessToken.current
    Wechat::AccessToken.current
    expect(Wechat::AccessToken).to have_received(:request).once
  end

  it "should return diff token with 5*60 seconds left" do
    allow(Wechat::AccessToken).to receive(:request).and_return({"access_token" => "ACCESS_TOKEN1", "expires_in" => 5*60+1})
    token1 = Wechat::AccessToken.current
    sleep 2
    allow(Wechat::AccessToken).to receive(:request).and_return({"access_token" => "ACCESS_TOKEN2", "expires_in" => 5*60+1})
    token2 = Wechat::AccessToken.current
    expect(token1).not_to eq(token2)
  end

  it "should return identical token in expires_in seconds" do
    allow(Wechat::AccessToken).to receive(:request).and_return({"access_token" => "ACCESS_TOKEN1", "expires_in" => 7200})
    token1 = Wechat::AccessToken.current
    sleep 2
    allow(Wechat::AccessToken).to receive(:request).and_return({"access_token" => "ACCESS_TOKEN2", "expires_in" => 7200})
    token2 = Wechat::AccessToken.current
    expect(token1).to eq(token2)
  end
end