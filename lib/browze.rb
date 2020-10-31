# frozen_string_literal: true

require 'browze/version'
require 'browze/client'
require 'browze/client/mobile'
require 'browze/client/desktop'
require 'browze/client/response'

module Browze
  # Create a new Browze instance.
  #
  # @param [Symbol] type
  # @return [Browze::Client]
  def self.start(type = :desktop)
    type == :mobile ? Browze::Client::Mobile.new : Browze::Client::Desktop.new
  end
end
