# frozen_string_literal: true

RSpec.describe Browze do
  let(:browser) { described_class.start }

  it 'has a version number' do
    expect(Browze::VERSION).not_to be nil
  end

  describe '.start' do
    it 'instantiates a desktop client by default' do
      expect(browser).to be_a Browze::Client::Desktop
    end
  end

  it 'has a user agent' do
    expect(browser.user_agent).to be_a String
  end

  describe '#user_agent' do
    it 'returns a random different user agent with different instances' do
      expect(browser.user_agent).not_to eq described_class.start.user_agent
    end

    it 'persists the user agent in the instance' do
      expect(browser.user_agent).to eq browser.user_agent
    end
  end

  describe '#get' do
    it 'gets the content from a url' do
      VCR.use_cassette('get:google.com') do
        response = browser.get('https://www.google.com/')
        expect(response.code).to eq 200
      end
    end
  end
end
