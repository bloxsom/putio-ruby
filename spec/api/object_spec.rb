require 'spec_helper'

describe Putio::Api::Object do
  before do
    class SomeClass < Putio::Api::Object; end
  end

  describe '#plural_name' do
    subject { SomeClass.plural_name }

    it 'returns the pluralized class name' do
      expect(subject).to eq('some_classes')
    end
  end

  describe '#singular_name' do
    subject { SomeClass.singular_name }

    it 'returns the singular class name' do
      expect(subject).to eq('some_class')
    end
  end

  describe '#parse_collection' do
    subject { SomeClass.parse_collection(hash) }

    let(:hash) do
      {
        :some_classes => [{:first => 'object'}, {:second => 'object'}],
        :status => 'OK',
      }
    end

    before do
      allow(SomeClass).to receive(:instantiate_object).and_return('some obj')
    end

    it 'instantiates an object for each hash in the collection' do
      expect(SomeClass).to receive(:instantiate_object).with({:first => 'object'}).once.ordered
      expect(SomeClass).to receive(:instantiate_object).with({:second => 'object'}).once.ordered
      subject
    end

    it 'returns an array of instantiated objects' do
      expect(subject).to eq(['some obj', 'some obj'])
    end
  end

  describe '#parse_object' do
    subject { SomeClass.parse_object(hash) }

    let(:hash) do
      {
        :some_class => {:only => 'object'},
        :status => 'OK',
      }
    end

    before do
      allow(SomeClass).to receive(:instantiate_object).and_return('some obj')
    end

    it 'instantiates an object for the hash' do
      expect(SomeClass).to receive(:instantiate_object).with({:only => 'object'}).once
      subject
    end

    it 'returns the instantiated object' do
      expect(subject).to eq('some obj')
    end
  end

  describe '#instantiate_object' do
    subject { SomeClass.instantiate_object(hash) }

    let(:mock_obj) { double }
    let(:hash) do
      {
        :foo => 'bar',
        :baz => 'qux'
      }
    end

    before do
      allow(SomeClass).to receive(:new).and_return(mock_obj)
      allow(mock_obj).to receive(:set_attribute)
    end

    it 'sets attributes on the object for each item in the hash' do
      expect(mock_obj).to receive(:set_attribute).with('foo', 'bar').once.ordered
      expect(mock_obj).to receive(:set_attribute).with('baz', 'qux').once.ordered
      subject
    end

    it 'returns the resulting object' do
      expect(subject).to eq(mock_obj)
    end
  end

  describe '#client' do
    subject { SomeClass.new.client }

    it 'refers to the client on the class' do
      expect(SomeClass).to receive(:client)
      subject
    end
  end

  describe '#set_attribute' do
    subject { some_class.set_attribute(:foo, 'bar') }

    let(:some_class) { SomeClass.new }

    context 'when the provided attr is missing' do
      subject { some_class.set_attribute(nil, 'bar') }

      it 'returns nil' do
        expect(subject).to be_nil
      end

      it 'does not add an attr_reader' do
        expect(subject.singleton_class).to_not receive(:instance_eval)
        subject
      end
    end

    context 'when the provided attr is present' do
      subject { some_class.set_attribute(:foo, 'bar') }

      it 'sets the attr on the class' do
        subject
        expect(some_class.foo).to eq('bar')
      end
    end
  end
end
