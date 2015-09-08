require 'spec_helper'

describe Putio::Transfer do
  describe '#list' do
    subject { Putio::Transfer.list }

    before do
      stub_request(:get, "https://api.put.io/v2/transfers/list?oauth_token=sometoken").
        to_return(:status => 200, :body => fixture("transfer_list.json"), :headers => {'content-type' => 'application/json'})
    end

    it 'returns transfers' do
      expect(subject.first.is_a?(Putio::Transfer)).to be_truthy
    end

    it 'returns a collection' do
      expect(subject.is_a?(Array)).to be_truthy
    end
  end

  describe '#transfer' do
    subject { Putio::Transfer.transfer(12345) }

    before do
      stub_request(:get, "https://api.put.io/v2/transfers/12345?oauth_token=sometoken").
        to_return(:status => 200, :body => fixture("transfer_get.json"), :headers => {'content-type' => 'application/json'})
    end

    it 'returns a transfer' do
      expect(subject.is_a?(Putio::Transfer)).to be_truthy
    end
  end

  describe '#add' do
    subject { Putio::Transfer.add("someurl") }
    before do
      stub_request(:post, "https://api.put.io/v2/transfers/add?oauth_token=sometoken").
        with(:body => {"url"=>"someurl"}).
        to_return(:status => 200, :body => fixture("transfer_get.json"), :headers => {'content-type' => 'application/json'})
    end

    it 'returns a transfer' do
      expect(subject.is_a?(Putio::Transfer)).to be_truthy
    end
  end

  describe '#fetch' do
    subject { Putio::Transfer.new(:id => 12345).fetch }

    it 'fetches the transfer' do
      expect(Putio::Transfer).to receive(:transfer).with(12345)
      subject
    end
  end
end
