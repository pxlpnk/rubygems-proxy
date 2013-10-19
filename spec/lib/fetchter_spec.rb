# encoding: utf-8
require 'fetcher'
require 'net/http'
require 'webmock'
include WebMock::API

describe Fetcher do
  describe 'on create' do
    it 'takes an url and a destination on creation do' do
      fetcher = Fetcher.new('http://localhost/', 'test_dir/test_file')
      expect(fetcher).to be_a_kind_of(Fetcher)
    end
  end

  describe 'retrives a remote gem' do
    before(:each) do
      @fetcher = Fetcher.new('http://localhost/', 'test_dir/test_file')
    end

    it 'returns the path to the file when it exists' do
      File.stub(:exists?).and_return(true)
      destination = @fetcher.fetch
      expect(destination).to eql('test_dir/test_file')
    end

    it 'fetches the file and returns the file when it doesn\'t exist' do
      pending
      File.stub(:exists?).and_return(false)
    end
  end

  describe '#fetch_gem' do
    before(:each) do
      @fetcher = Fetcher.new('http://localhost/', 'test_dir/test_file')
    end

    it 'returns the path to the gem on HTTPSuccess' do
      pending
      stub_request(:any, 'http://localhost/')
        .to_return(
        body: 'abc', status: 200, headers: { 'Content-Length' => 3 })

      @fetcher.should_receive(:write_to_file).and_return 'path'

      @fetcher.fetch_gem
    end
  end

  describe '#write_to_file' do
    before(:each) do
      @destination = 'test_dir/test_file'
      @fetcher = Fetcher.new('http://localhost/', @destination)
    end

    it 'opens the destination file in w+ mode and writes to it' do
      file = double(File)
      response = double
      @fetcher.should_receive(:write).and_return @destination
      File.should_receive(:open)
        .and_yield(file)

      expect(@fetcher.write_to_file(response)).to eql(@destination)
    end
  end
end
