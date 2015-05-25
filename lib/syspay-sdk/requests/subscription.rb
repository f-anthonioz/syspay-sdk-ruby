module SyspaySDK::Requests
  class Subscription < SyspaySDK::Requests::BaseClass
    METHOD = "POST"
    PATH = "/api/v1/merchant/subscription"

    FLOW_API = 'API'
    FLOW_BUYER = 'BUYER'
    FLOW_SELLER = 'SELLER'

    attr_accessor :flow,
    :subscription,
    :customer,
    :payment_method,
    :threatmetrix_session_id,
    :credit_card,
    :use_subscription,
    :use_billing_agreement

    def build_response response
      raise SyspaySDK::Exceptions::BadArgumentTypeError.new("response must be a Hash") unless response.is_a?(Hash)
      raise SyspaySDK::Exceptions::UnexpectedResponseError.new('Unable to retrieve "subscription" data from response') if response[:subscription].nil?

      subscription = SyspaySDK::Entities::Subscription::build_from_response(response[:subscription]);

      subscription.redirect = response[:redirect] unless response[:redirect].nil?
      subscription
    end

    def get_data
      hash = {}

      [ :flow, :payment_method, :threatmetrix_session_id, :use_subscription, :use_billing_agreement ].each do |attribute|
        hash[attribute] = self.send(attribute)
      end

      hash[:credit_card] = self.credit_card.to_hash unless self.credit_card.nil?
      hash[:customer] = self.customer.to_hash unless self.customer.nil?
      hash[:subscription] = self.subscription.to_hash unless self.subscription.nil?

      hash
    end
  end
end