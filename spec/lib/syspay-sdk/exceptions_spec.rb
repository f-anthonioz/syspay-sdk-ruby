describe SyspaySDK::Exceptions::RequestError do
  let(:uuid)          { 'uid' }
  let(:http_code)     { 'foo' }
  let(:response_body) { 'bar' }

  subject { described_class.new uuid, http_code, response_body }

  it { is_expected.to be_a StandardError }

  it 'is initialized with an http error code and the response body' do
    expect(subject.instance_variable_get(:@uuid)).to eq(uuid)
    expect(subject.instance_variable_get(:@http_code)).to eq(http_code)
    expect(subject.instance_variable_get(:@response_body)).to eq(response_body)
  end

  it 'prints out a specific message' do
    expect(subject.to_s).to eq("The request #{uuid} returned a #{http_code} error with the following body: #{response_body}")
  end
end

describe SyspaySDK::Exceptions::UnhandledMethodError do
  it { is_expected.to be_a StandardError }
end

describe SyspaySDK::Exceptions::InvalidChecksumError do
  it { is_expected.to be_a StandardError }
end

describe SyspaySDK::Exceptions::MissingArgumentError do
  it { is_expected.to be_a StandardError }
end

describe SyspaySDK::Exceptions::InvalidArgumentError do
  it { is_expected.to be_a StandardError }
end

describe SyspaySDK::Exceptions::UnexpectedResponseError do
  it { is_expected.to be_a StandardError }
end

describe SyspaySDK::Exceptions::BadArgumentTypeError do
  it { is_expected.to be_a StandardError }
end

describe SyspaySDK::Exceptions::NotImplementedError do
  it { is_expected.to be_a StandardError }
end

describe SyspaySDK::Exceptions::MissingConfig do
  it { is_expected.to be_a StandardError }
end

describe SyspaySDK::Exceptions::EMSError do
  let(:message) { 'message' }
  let(:error_code) { 1234 }

  subject { described_class.new message, error_code }

  it { is_expected.to be_a StandardError }
  it { is_expected.to respond_to(:error_code) }

  it 'is initialized with a message and an error code' do
    expect(subject.instance_variable_get(:@message)).to eq(message)
    expect(subject.instance_variable_get(:@error_code)).to eq(error_code)
  end

  it 'prints out a specific message' do
    expect(subject.to_s).to eq("#{message}. Error code : #{error_code}")
  end
end
