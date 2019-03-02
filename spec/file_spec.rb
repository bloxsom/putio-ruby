require 'spec_helper'

describe Putio::File do
  describe '#list' do
    subject { Putio::File.list }

    before do
      stub_request(:get, "https://api.put.io/v2/files/list?oauth_token=sometoken").
        to_return(:status => 200, :body => fixture("file_list.json"), :headers => {'content-type' => 'application/json'})
    end

    it 'returns files' do
      expect(subject.first.is_a?(Putio::File)).to be_truthy
    end

    it 'returns a collection' do
      expect(subject.is_a?(Array)).to be_truthy
    end
  end

  describe '#search' do
    subject { Putio::File.search("type: video") }

    before do
      stub_request(:get, "https://api.put.io/v2/files/search?oauth_token=sometoken&query=type:%20video").
        to_return(:status => 200, :body => fixture("file_list.json"), :headers => {'content-type' => 'application/json'})
    end

    it 'returns files' do
      expect(subject.first.is_a?(Putio::File)).to be_truthy
    end

    it 'returns a collection' do
      expect(subject.is_a?(Array)).to be_truthy
    end
  end

  describe '#file' do
    subject { Putio::File.file(12345) }

    before do
      stub_request(:get, "https://api.put.io/v2/files/12345?oauth_token=sometoken").
        to_return(:status => 200, :body => fixture("file_get.json"), :headers => {'content-type' => 'application/json'})
    end

    it 'returns a file' do
      expect(subject.is_a?(Putio::File)).to be_truthy
    end
  end

  describe '#download_url' do
    subject { Putio::File.new(:id => 12345).download_url }

    before do
      stub_request(:get, "https://api.put.io/v2/files/12345/download?oauth_token=sometoken").
        to_return(:status => 302, :body => '', :headers => {'content-type' => 'text/html', 'location' => 'https://someurl.com/file.file'})
    end

    it 'returns the download link' do
      expect(subject).to eq('https://someurl.com/file.file')
    end
  end

  describe 'delete' do
    subject { Putio::File.new(:id => 12345).delete }

    before do
      stub_request(:post, "https://api.put.io/v2/files/delete?oauth_token=sometoken").
        with(:body => {"file_ids"=>"12345"}).
        to_return(:status => 200, :body => '{"status": "OK"}', :headers => {'content-type' => 'application/json'})
    end

    it 'does not raise an error' do
      expect{subject}.to_not raise_error
    end
  end

  describe 'rename' do
    subject { Putio::File.new(:id => 12345).rename("New name") }

    before do
      stub_request(:post, "https://api.put.io/v2/files/rename?oauth_token=sometoken").
        with(:body => {"file_id"=>"12345", "name"=>"New name"}).
        to_return(:status => 200, :body => '{"status": "OK"}', :headers => {'content-type' => 'application/json'})
    end

    it 'does not raise an error' do
      expect{subject}.to_not raise_error
    end
  end
end
