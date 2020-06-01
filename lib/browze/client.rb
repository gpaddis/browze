# frozen_string_literal: true

module Browze
  # Desktop and mobile clients inherit from the base client.
  class Client
    # Perform a GET request to the given url.
    def get(url)
      HTTParty.get(url, headers: { 'User-Agent' => user_agent })
    end

    # Choose a random user agent.
    def user_agent
      @user_agent ||= self.class::USER_AGENTS[rand(self.class::USER_AGENTS.length)]
    end
  end
end
