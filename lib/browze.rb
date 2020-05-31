# frozen_string_literal: true

require 'httparty'
require 'browze/version'
require 'browze/client'
require 'browze/client/mobile'
require 'browze/client/desktop'

module Browze
  def self.start(type = :desktop)
    type == :mobile ? Browze::Client::Mobile.new : Browze::Client::Desktop.new
  end
end
