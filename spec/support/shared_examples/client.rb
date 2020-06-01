# frozen_string_literal: true

RSpec.shared_examples 'client' do
  it 'has a user agent' do
    expect(described_class.new.user_agent).to be_a String
  end

  describe '#user_agent' do
    it 'returns a random different user agent with different instances' do
      expect(described_class.new.user_agent).not_to eq described_class.new.user_agent
    end

    it 'persists the user agent in the instance' do
      browser = described_class.new
      expect(browser.user_agent).to eq browser.user_agent
    end
  end

  describe '#get' do
    let(:browser) { described_class.new }
    let(:response) do
      VCR.use_cassette('get:google.com') do
        browser.get('https://www.google.com/')
      end
    end

    it 'gets the content from a url' do
      expect(response).to be_a Browze::Client::Response
      expect(response.body).to be_a String
      expect(response.code).to eq 200
    end

    it 'automatically parses the HTML response with Nokogiri' do
      expect(response.parsed).to be_a Nokogiri::HTML::Document
    end

    it 'saves the cookies received with the response' do
      expect(response.set_cookie).to be_an Array
      expect(browser.cookies).to include(domain: '.google.com')
    end

    skip 'sends the cookies received in the previous response' do
    end
  end
end
