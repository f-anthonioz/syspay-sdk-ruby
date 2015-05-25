require 'spec_helper'

describe SyspaySDK::Requests::Void do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'POST'" do
      SyspaySDK::Requests::Void::METHOD.should eq('POST')
    end

    it "has a PATH class constant set to '/api/v1/merchant/payment/:payment_id/void'" do
      SyspaySDK::Requests::Void::PATH.should eq('/api/v1/merchant/payment/:payment_id/void')
    end
  end

  describe "Attributes" do
    it { should respond_to(:payment_id) }
  end

  describe "Initialize" do
    it "can be initialized with a payment_id parameter" do
      subscription_cancellation = SyspaySDK::Requests::Void.new "test_payment_id"
      subscription_cancellation.payment_id.should eq("test_payment_id")
    end

    it "can be initialized without arguments" do
      subscription_cancellation = SyspaySDK::Requests::Void.new
      subscription_cancellation.payment_id.should be_nil
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::Void::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::Void::PATH)
    end
    it "returns the PATH constant with payment_id if exists" do
      with_payment_id = SyspaySDK::Requests::Void.new "test_payment_id"
      with_payment_id.get_path.should eq(SyspaySDK::Requests::Void::PATH.gsub(/:payment_id/, "test_payment_id"))
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError the hash doesn't contain payment" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an SyspaySDK::Entities::Payment" do
      subject.build_response({ payment: {} }).should be_a(SyspaySDK::Entities::Payment)
    end

    it "sets the redirect attribute of payment" do
      payment = subject.build_response({ payment: {}, redirect: "test_redirect" })
      payment.redirect.should eq("test_redirect")
    end
  end
end