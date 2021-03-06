module SyspaySDK
  module Requests
    class PaymentInfo < SyspaySDK::Requests::BaseClass
      METHOD = 'GET'.freeze
      PATH = '/api/v1/merchant/payment/'.freeze

      attr_accessor :payment_id

      def path
        "#{PATH}#{payment_id}"
      end

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "payment" data from response' if response[:payment].nil?

        payment = SyspaySDK::Entities::Payment.build_from_response(response[:payment])

        payment.redirect = response[:redirect] unless response[:redirect].nil?

        payment
      end

      def data
        hash = {}
        hash[:payment_id] = payment_id
        hash
      end
    end
  end
end
