# frozen_string_literal: true

require 'down'
require 'geocoder'
require 'httparty'
require 'fileutils'

module Browze
  # Desktop and mobile clients inherit from the base client.
  class Client
    include HTTParty

    attr_reader :cookies
    attr_writer :headers

    # Initialize the cookie jar.
    def initialize
      @cookies = CookieHash.new
      @headers = Hash.new
    end

    # Perform a GET request to the given url.
    def get(url)
      resp = Browze::Client::Response.new(self.class.get(url, headers: headers))
      resp.set_cookie.each { |c| @cookies.add_cookies(c) }
      resp
    end

    # Perform a POST request to the given url with a request body.
    def post(url, body_hash)
      resp = Browze::Client::Response.new(self.class.post(url, body: body_hash, headers: headers))
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

    # Get the updated headers.
    def headers
      @headers.merge({ 'User-Agent' => user_agent, 'Cookie' => @cookies.to_cookie_string })
    end

    # Pick a random user agent and persist it in the instance.
    def user_agent
      @user_agent ||= self.class::USER_AGENTS[rand(self.class::USER_AGENTS.length)]
    end

    # Get the current public ip address.
    def ip
      @ip ||= get('http://whatismyip.akamai.com').body
    end

    # Return the current location based on the public ip address.
    def location
      l = Geocoder.search(ip).first
      "#{l.city}, #{l.country}"
    end
  end
end
