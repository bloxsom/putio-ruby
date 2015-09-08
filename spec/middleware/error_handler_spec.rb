require 'spec_helper'

describe Putio::Middleware::ErrorHandler do
  subject { client.get url }

  let(:client) { Putio::Api::Object.new.client }
  let(:url) { 'https://api.put.io/v2/things/' }

  context 'when a response status is 500' do
    before do
      stub_request(:get, "#{url}?oauth_token=sometoken").
        to_return(:status => 500, :body => '')
    end

    it 'raises an error' do
      expect{subject}.to raise_error(Putio::ServerError)
    end
  end

  context 'when a response status is 400' do
    before do
      stub_request(:get, "#{url}?oauth_token=sometoken").
        to_return(:status => 400, :body => '')
    end

    it 'raises an error' do
      expect{subject}.to raise_error(Putio::BadRequest)
    end
  end
end
