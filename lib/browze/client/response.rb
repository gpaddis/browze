# frozen_string_literal: true

require 'nokogiri'

module Browze
  # Wrap the HTTParty response to assign custom attributes.
  class Client::Response
    attr_reader :body,
                :code,
                :original

    def initialize(response)
      @body = response.body
      @code = response.code
      @original = response
    end

    def parsed
      Nokogiri::HTML(body)
    end

    # Get the cookies in the set-cookie header field.
    def set_cookie
      original.get_fields('Set-Cookie')
    end
  end
end
