module SyspaySDK
  module Requests
    class Refund < SyspaySDK::Requests::BaseClass
      METHOD = 'POST'.freeze
      PATH = '/api/v1/merchant/refund'.freeze

      attr_accessor :payment_id, :ems_url, :refund

      def build_response(response)
        raise SyspaySDK::Exceptions::BadArgumentTypeError, 'response must be a Hash' unless response.is_a?(Hash)
        raise SyspaySDK::Exceptions::UnexpectedResponseError, 'Unable to retrieve "refund" data from response' if response[:refund].nil?

        SyspaySDK::Entities::Refund.build_from_response(response[:refund])
      end

      def data
        hash = {}
        hash = refund.to_hash unless refund.nil?
        hash[:payment_id] = payment_id
        hash[:ems_url] = ems_url unless ems_url.nil?
        hash
      end
    end
  end
end
