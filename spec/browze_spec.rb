# frozen_string_literal: true

RSpec.describe Browze do
  it 'has a version number' do
    expect(Browze::VERSION).not_to be nil
  end

  describe '#get' do
    let(:browser) { described_class.new }

    it 'gets the content from a url' do
      VCR.use_cassette('get:google.com') do
        response = browser.get('https://www.google.com/')
        expect(response.code).to eq 200
      end
    end
  end
end
