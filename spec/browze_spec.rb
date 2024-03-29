# frozen_string_literal: true

RSpec.describe Browze do
  let(:browser) { described_class.start }

  it 'has a version number' do
    expect(Browze::VERSION).not_to be nil
  end

  describe '.start' do
    it 'can instantiate a mobile client' do
      expect(described_class.start(:mobile)).to be_a Browze::Client::Mobile
    end

    it 'can instantiate a desktop client' do
      expect(described_class.start(:desktop)).to be_a Browze::Client::Desktop
    end

    it 'instantiates a desktop client by default' do
      expect(browser).to be_a Browze::Client::Desktop
    end
  end
end
