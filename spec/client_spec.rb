# frozen_string_literal: true

RSpec.describe Browze::Client do
  let(:browser) { Browze.start }

  it 'has a user agent' do
    expect(browser.user_agent).to be_a String
  end

  describe '#user_agent' do
    it 'returns a random different user agent with different instances' do
      expect(browser.user_agent).not_to eq Browze.start.user_agent
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
