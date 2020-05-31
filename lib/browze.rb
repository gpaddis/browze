# frozen_string_literal: true

require 'httparty'
require 'browze/version'
require 'browze/client'
require 'browze/client/desktop'

module Browze
  def self.start
    Browze::Client::Desktop.new
  end
end
