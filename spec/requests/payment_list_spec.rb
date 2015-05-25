require 'spec_helper'

describe SyspaySDK::Requests::PaymentList do
  it "is a SyspaySDK::Requests::BaseClass" do
    subject.should be_a(SyspaySDK::Requests::BaseClass)
  end

  describe "Constants" do
    it "has a METHOD class constant set to 'GET'" do
      SyspaySDK::Requests::PaymentList::METHOD.should eq('GET')
    end

    it "has a PATH class constant set to '/api/v1/merchant/payments/'" do
      SyspaySDK::Requests::PaymentList::PATH.should eq('/api/v1/merchant/payments/')
    end
  end

  describe "Attributes" do
    it { should respond_to(:filters) }
  end

  describe "Initialize" do
    it "creates a hash of filter" do
      billing_agreement_list = SyspaySDK::Requests::PaymentList.new
      billing_agreement_list.filters.should be_a(Hash)
    end
  end

  it { should respond_to(:get_method) }

  describe "#get_method" do
    it "returns the METHOD constant" do
      subject.get_method.should eq(SyspaySDK::Requests::PaymentList::METHOD)
    end
  end

  it { should respond_to(:get_path) }

  describe "#get_path" do
    it "returns the PATH constant" do
      subject.get_path.should eq(SyspaySDK::Requests::PaymentList::PATH)
    end
  end

  it { should respond_to(:add_filter) }

  describe "#add_filter" do
    it 'adds a filter to instance' do
      subject.add_filter :test, "test"
      subject.filters.should include(test: "test")
    end
  end

  it { should respond_to(:delete_filter) }

  describe "#delete_filter" do
    it 'deletes a filter from instance' do
      subject.add_filter :test, "test"
      subject.add_filter :test2, "test2"
      subject.delete_filter :test
      subject.filters.should include(test2: "test2")
      subject.filters.should_not include(test: "test")
    end
  end

  it { should respond_to(:get_data) }

  describe "#get_data" do
    it "returns a hash containing the filters" do
      subject.add_filter :test, "test"
      subject.add_filter :test2, "test2"
      subject.get_data.should eq(test: "test", test2: "test2")
    end
  end

  it { should respond_to(:build_response) }

  describe "#build_response" do
    it "raises a SyspaySDK::Exceptions::BadArgumentTypeError when anything but a hash is passed in" do
      lambda do
        subject.build_response("test")
      end.should raise_error(SyspaySDK::Exceptions::BadArgumentTypeError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError if the hash doesn't contain payments" do
      lambda do
        subject.build_response({test: "test"})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "raises a SyspaySDK::Exceptions::UnexpectedResponseError if payments is not an array" do
      lambda do
        subject.build_response({payments: {}})
      end.should raise_error(SyspaySDK::Exceptions::UnexpectedResponseError)
    end

    it "returns an Array of SyspaySDK::Entities::Payment" do
      subject.build_response({ payments: [] }).should be_a(Array)
      subject.build_response({ payments: [{id: 1}] }).first.should be_a(SyspaySDK::Entities::Payment)
    end
  end
end