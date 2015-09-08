require 'spec_helper'

describe Putio do
  it 'has a version number' do
    expect(Putio::VERSION).not_to be nil
  end

  describe '#configure' do
    subject do
      Putio.configure { |config| config.oauth_token = 'sometoken' }
    end

    it 'sets the oauth_token' do
      subject
      expect(Putio.configuration.oauth_token).to eq('sometoken')
    end
  end
end
