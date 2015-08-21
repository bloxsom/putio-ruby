require 'spec_helper'

describe Putio::File do
  before do
    Putio.configure :oauth_token => 'some_token'
    Putio::File.instance_variable_set(:@client, nil)
  end

  describe '#list' do
    subject { Putio::File.list }

    let(:json) do
      '{ "some": "response" }'
    end
    let(:parsed_json) do
      { :some => "response" }
    end

    context 'when the request succeeds' do
      before do
        stub_request(Putio::File.client) do |stub|
          stub.get "/v2/files/list" do
            [200, {}, json]
          end
        end
      end

      it 'parses the collection' do
        expect(Putio::File).to receive(:parse_collection).with(parsed_json)
        subject
      end

    end

    context 'when the request fails' do
      before do
        stub_request(Putio::File.client) do |stub|
          stub.get "/v2/files/list" do
            [500, {}, json]
          end
        end
      end

      it 'does not parse the collection' do
        expect(Putio::File).to_not receive(:parse_collection)
        subject
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when a parent_id is provided' do
      subject { Putio::File.list(1234) }

      before do
        stub_request(Putio::File.client) do |stub|
          stub.get "/v2/files/list?oauth_token=some_token&parent_id=1234" do
            [200, {}, json]
          end
        end
        allow(Putio::File).to receive(:parse_collection)
      end


      it 'includes the parent_id in the request' do
        expect{subject}.to_not raise_error
      end
    end
  end

  describe '#get' do
    subject { Putio::File.get(1234) }

    let(:json) do
      '{ "some": "response" }'
    end
    let(:parsed_json) do
      { :some => "response" }
    end

    context 'when the request succeeds' do
      before do
        stub_request(Putio::File.client) do |stub|
          stub.get "/v2/files/1234" do
            [200, {}, json]
          end
        end
      end

      it 'parses the object' do
        expect(Putio::File).to receive(:parse_object).with(parsed_json)
        subject
      end
    end

    context 'when the request fails' do
      before do
        stub_request(Putio::File.client) do |stub|
          stub.get "/v2/files/1234" do
            [500, {}, json]
          end
        end
      end

      it 'does not parse the object' do
        expect(Putio::File).to_not receive(:parse_object)
        subject
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#download_url' do
    subject { file.download_url }

    let(:file) { Putio::File.new }

    before do
      allow(file).to receive(:id).and_return(1234)
    end

    context 'when the request succeeds' do
      before do
        stub_request(Putio::File.client) do |stub|
          stub.get "/v2/files/1234/download" do
            [200, {:location => 'someurl'}, '']
          end
        end
      end

      it 'returns the download url' do
        expect(subject).to eq("someurl")
      end
    end

    context 'when the request fails' do
      before do
        stub_request(Putio::File.client) do |stub|
          stub.get "/v2/files/1234/download" do
            [500, {}, '']
          end
        end
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#delete' do
    subject { file.delete }

    let(:file) { Putio::File.new }

    before do
      stub_request(Putio::File.client) do |stub|
        stub.post "/v2/files/delete?oauth_token=some_token", "file_ids=1234" do
          [200, {}, '']
        end
      end
      allow(file).to receive(:id).and_return(1234)
    end

    it 'deletes the file' do
      expect{subject}.to_not raise_error
    end
  end
end
