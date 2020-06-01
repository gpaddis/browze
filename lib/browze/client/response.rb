# frozen_string_literal: true

require 'nokogiri'

module Browze
  # Wrap the HTTParty response to assign custom attributes.
  class Client::Response
    attr_reader :code, :body, :parsed, :original

    def initialize(response)
      @original = response
      @code = response.code
      @body = response.body
      @parsed = Nokogiri::HTML(response.body)
    end
  end
end
