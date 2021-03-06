module SyspaySDK
  module Requests
    class BillingAgreementInfo < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/billing-agreement/'.freeze

      attr_accessor :billing_agreement_id

      def initialize(billing_agreement_id = nil)
        self.billing_agreement_id = billing_agreement_id
      end

      def path
        "#{PATH}#{billing_agreement_id}"
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "billing_agreement" data from response' if response[:billing_agreement].nil?

        SyspaySDK::Entities::BillingAgreement.build_from_response(response[:billing_agreement])
      end
    end
  end
end
