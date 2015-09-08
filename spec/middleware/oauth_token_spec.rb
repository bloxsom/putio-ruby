require 'spec_helper'

describe Putio::Middleware::OauthToken do
  subject { client.get url }

  let(:client) { Putio::Api::Object.new.client }
  let(:url) { 'https://api.put.io/v2/things/' }

  context 'when no oauth token is provided' do
    before do
      Putio.configure do |config|
        config.oauth_token = nil
      end
    end

    after do
      Putio.configure do |config|
        config.oauth_token = 'sometoken'
      end
    end

    it 'raises an error' do
      expect{subject}.to raise_error(Putio::ApplicationCredentialsRequired)
    end
  end

  context 'when an oauth token is provided' do
    before do
      stub_request(:get, "#{url}?oauth_token=sometoken").
        to_return(:status => 200)
    end

    it 'includes the oauth token in the request' do
      expect(subject.success?).to be_truthy
    end
  end
end
