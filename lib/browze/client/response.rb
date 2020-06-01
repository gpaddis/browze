# frozen_string_literal: true

module Browze
  # Wrap the HTTParty response to assign custom attributes.
  class Client::Response
    attr_reader :code, :body, :parsed

    def initialize(code:, body:, parsed:)
      @code = code
      @body = body
      @parsed = parsed
    end
  end
end
