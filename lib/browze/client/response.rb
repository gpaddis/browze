# frozen_string_literal: true

require 'nokogiri'

module Browze
  # Wrap the HTTParty response to assign custom attributes.
  class Client::Response
    attr_reader :body,
                :code,
                :original

    # Initialize the Response object with the original response data.
    #
    # @param [HTTParty::Response] response
    def initialize(response)
      @body = response.body
      @code = response.code
      @original = response
    end

    def parsed
      Nokogiri::HTML(body)
    end

    # Get the cookies in the set-cookie header field.
    #
    # @return [Array] the cookies to be set in the client headers.
    def set_cookie
      original.get_fields('Set-Cookie') || []
    end
  end
end
