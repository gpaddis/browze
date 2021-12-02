# frozen_string_literal: true

RSpec.shared_examples 'client' do
  subject(:browser) { described_class.new }

  it 'has a user agent' do
    expect(browser.user_agent).to be_a String
  end

  describe '#user_agent' do
    it 'returns a random different user agent with different instances', retry: 3 do
      expect(browser.user_agent).not_to eq described_class.new.user_agent
    end

    it 'keeps using the same user_agent once instantiated' do
      expect(browser.user_agent).to eq browser.user_agent
    end
  end

  describe '#get' do
    around(:each) do |example|
      VCR.use_cassette('get:google.com', &example)
    end

    let(:response) { browser.get('https://www.google.com/') }

    it 'gets the content from a url' do
      expect(response).to be_a Browze::Response
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
  end

  describe 'headers' do
    it 'can add custom headers to the browser' do
      browser.headers = { foo: 'bar' }
      expect(browser.headers).to include(foo: 'bar')
      expect(browser.headers.count).to eq 3
    end
  end
end
