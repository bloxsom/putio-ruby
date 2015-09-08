require 'spec_helper'

describe Putio::Middleware::ParseRoot do
  subject { client.get url }

  let(:client) { Putio::Api::Object.new.client }

  before do
    stub_request(:get, "#{url}?oauth_token=sometoken").
      to_return(:status => 200, :body => body, :headers => {'content-type' => 'application/json'})
  end

  context 'when the url contains a plural resource' do
    let(:url) { 'https://api.put.io/v2/things/' }
    let(:body) do
      '{ "things": [ {"thing1": "thing"} ] }'
    end

    it 'returns only the contents of the resource' do
      expect(subject.body).to eq([{"thing1" => "thing"}])
    end
  end

  context 'when the url contains a singular resource' do
    let(:url) { 'https://api.put.io/v2/thing/' }
    let(:body) do
      '{ "thing": {"thing1": "thing"} }'
    end

    it 'returns only the contents of the resource' do
      expect(subject.body).to eq({"thing1" => "thing"})
    end
  end
end
