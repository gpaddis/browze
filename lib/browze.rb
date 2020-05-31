# frozen_string_literal: true

require 'httparty'

class Browze
  VERSION = '0.1.0'

  def get(url)
    HTTParty.get(url)
  end
end
