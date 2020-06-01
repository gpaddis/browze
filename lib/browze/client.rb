# frozen_string_literal: true

require 'down'
require 'httparty'
require 'fileutils'

module Browze
  # Desktop and mobile clients inherit from the base client.
  class Client
    include HTTParty

    attr_reader :cookies

    def initialize
      @cookies = CookieHash.new
    end

    # Perform a GET request to the given url.
    def get(url)
      resp = Browze::Client::Response.new(self.class.get(url, headers: { 'User-Agent' => user_agent }))
      resp.set_cookie.each { |c| @cookies.add_cookies(c) }
      resp
    end

    # TODO: show download progress
    def download(url, filename: nil)
      puts 'Downloading...'
      tempfile = Down.download(url,
                               content_length_proc: ->(c) { puts c },
                               progress_proc: ->(p) { puts p })
      filename ||= tempfile.original_filename
      FileUtils.mv(tempfile, filename)
      puts filename
      puts 'Download complete!'
    end

    # Choose a random user agent.
    def user_agent
      @user_agent ||= self.class::USER_AGENTS[rand(self.class::USER_AGENTS.length)]
    end
  end
end
