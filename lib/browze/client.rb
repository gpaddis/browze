# frozen_string_literal: true

module Browze
  class Client
    # Perform a GET request to the given url.
    def get(url)
      HTTParty.get(url)
    end
  end
end
