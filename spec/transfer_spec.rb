require 'spec_helper'

describe Putio::Transfer do
  before do
    Putio.configure :oauth_token => 'some_token'
    Putio::Transfer.instance_variable_set(:@client, nil)
  end

  describe '#list' do
    subject { Putio::Transfer.list }

    let(:json) do
      '{ "some": "response" }'
    end
    let(:parsed_json) do
      { :some => "response" }
    end

    context 'when the request succeeds' do
      before do
        stub_request(Putio::Transfer.client) do |stub|
          stub.get "/v2/transfers/list" do
            [200, {}, json]
          end
        end
      end

      it 'parses the collection' do
        expect(Putio::Transfer).to receive(:parse_collection).with(parsed_json)
        subject
      end

    end

    context 'when the request fails' do
      before do
        stub_request(Putio::Transfer.client) do |stub|
          stub.get "/v2/transfers/list" do
            [500, {}, json]
          end
        end
      end

      it 'does not parse the collection' do
        expect(Putio::Transfer).to_not receive(:parse_collection)
        subject
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#get' do
    subject { Putio::Transfer.get(1234) }

    let(:json) do
      '{ "some": "response" }'
    end
    let(:parsed_json) do
      { :some => "response" }
    end

    context 'when the request succeeds' do
      before do
        stub_request(Putio::Transfer.client) do |stub|
          stub.get "/v2/transfers/1234" do
            [200, {}, json]
          end
        end
      end

      it 'parses the object' do
        expect(Putio::Transfer).to receive(:parse_object).with(parsed_json)
        subject
      end
    end

    context 'when the request fails' do
      before do
        stub_request(Putio::Transfer.client) do |stub|
          stub.get "/v2/transfers/1234" do
            [500, {}, json]
          end
        end
      end

      it 'does not parse the object' do
        expect(Putio::Transfer).to_not receive(:parse_object)
        subject
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#add' do
    before do
      stub_request(Putio::Transfer.client) do |stub|
        stub.post "/v2/transfers/add", :url => 'someurl' do
          [200, {}, '']
        end
      end
    end

    it 'adds the transfer' do
      expect{subject}.to_not raise_error
    end
  end
end
