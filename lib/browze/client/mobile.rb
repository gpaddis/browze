# frozen_string_literal: true

module Browze
  class Client::Mobile < Browze::Client
    # Most used mobile user agents.
    USER_AGENTS = [
      'agent...'
    ].freeze

    # Choose a random user agent.
    def user_agent
      @user_agent ||= USER_AGENTS[rand(USER_AGENTS.length)]
    end
  end
end
