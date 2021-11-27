# frozen_string_literal: true

require 'down'
require 'geocoder'
require 'httparty'
require 'fileutils'
require 'tty-progressbar'

module Browze
  # Desktop and mobile clients inherit from the base client.
  class Client
    include HTTParty

    attr_reader :cookies
    attr_writer :headers

    # Initialize the cookie jar and headers.
    def initialize
      @cookies = CookieHash.new
      @headers = {}
    end

    # Perform a GET request to the given url.
    #
    # @param [String] url
    # @return [Browze::Response]
    def get(url)
      resp = Browze::Response.new(self.class.get(url, headers: headers))
      resp.set_cookie.each { |c| @cookies.add_cookies(c) }
      resp
    end

    # Perform a POST request to the given url with a request body.
    #
    # @param [String] url
    # @param [Hash] body_hash
    # @return [Browze::Response]
    def post(url, body_hash)
      resp = Browze::Response.new(self.class.post(url, body: body_hash, headers: headers))
      resp.set_cookie.each { |c| @cookies.add_cookies(c) }
      resp
    end

    # Download a file with an optional filename.
    #
    # @param [String] url
    # @param [String] filename
    def download(url, filename: nil)
      bar = TTY::ProgressBar.new('Downloading... [:bar] :percent')
      tempfile = Down.download(
        url,
        content_length_proc: ->(content_length) { bar.update(total: content_length) },
        progress_proc: ->(progress) { bar.current = progress }
      )
      filename ||= tempfile.original_filename
      FileUtils.mv(tempfile, filename)
      puts "Download complete: #{filename} (#{tempfile.size} bytes)"
    end

    # Get the updated headers.
    #
    # @return [Hash]
    def headers
      @headers.merge({ 'User-Agent' => user_agent, 'Cookie' => @cookies.to_cookie_string })
    end

    # Pick a random user agent and persist it in the instance.
    #
    # @return [String]
    def user_agent
      @user_agent ||= self.class::USER_AGENTS[rand(self.class::USER_AGENTS.length)]
    end

    # Get the current public ip address.
    #
    # @return [String] the IP address
    def ip
      @ip ||= get('http://whatismyip.akamai.com').body
    end

    # Return the current location based on the public ip address.
    #
    # @return [String]
    def location
      l = Geocoder.search(ip).first
      "#{l.city}, #{l.country}"
    end
  end
end
