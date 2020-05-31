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
    it 'gets the content from a url' do
      VCR.use_cassette('get:google.com') do
        response = described_class.new.get('https://www.google.com/')
        expect(response.code).to eq 200
      end
    end
  end
end
