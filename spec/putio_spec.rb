require 'spec_helper'

describe Putio do
  it 'has a version number' do
    expect(Putio::VERSION).not_to be nil
  end

  describe '#configure' do
    subject { Putio.configure(:oauth_token => 'sometoken') }

    it 'sets the oauth_token' do
      subject
      expect(Putio.oauth_token).to eq('sometoken')
    end
  end
end
