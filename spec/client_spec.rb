require "spec_helper"

describe SyspaySDK::Client do
  it "is initialized with the values set in configuration" do
    client = SyspaySDK::Client.new
    client.syspay_id.should eq(Config.config.syspay_id)
    client.syspay_passphrase.should eq(Config.config.syspay_passphrase)
    client.syspay_base_url.should eq(Config.config.syspay_base_url)
  end

  it "has a username" do
    should respond_to(:syspay_id)
  end

  it "has a secret" do
    should respond_to(:syspay_passphrase)
  end

  it "has a base_url" do
    should respond_to(:syspay_base_url)
  end

  it "has a request_object" do
    should respond_to(:request_object)
  end

  it "has a response" do
    should respond_to(:response)
  end

  it "responds to request" do
    should respond_to(:request)
  end

  it "responds to generate_auth_header" do
      should respond_to(:generate_auth_header)
  end

  it "responds to generate_digest_for_auth_header" do
      should respond_to(:generate_digest_for_auth_header)
  end

  describe "#generate_digest_for_auth_header" do
    it "returns a digest based on the nonce, timestamp and passphrase passed in as parameters" do
      require "base64"
      require 'digest/sha1'

      nonce = rand()
      timestamp = Time.now.to_i
      passphrase = "123abc456def"
      result = Base64.strict_encode64(Digest::SHA1.hexdigest("#{nonce}#{timestamp}#{passphrase}"))
      subject.generate_digest_for_auth_header(nonce, timestamp, passphrase).should eq(result)
    end
  end

  describe "#generate_auth_header" do
    it "returns a properly formatted x-wsse Header" do
      Config.config.syspay_id = "123abc456def"
      SyspaySDK::Client.new.generate_auth_header.should match(/AuthToken MerchantAPILogin='123abc456def', PasswordDigest='.*', Nonce='.*', Created='\d*'/)
    end
  end
end