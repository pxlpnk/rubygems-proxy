# encoding: utf-8

require 'net/http'
require 'fileutils'

# Fetches remote gems and serves them

class Fetcher

  PORT = 80

  def initialize(url, destination)
    @url = URI.parse(url.to_s)
    @destination = destination
  end

  def write_to_file(response)
    FileUtils.mkdir_p(File.dirname(@destination))
    File.open(@destination, 'w+') do |file|
      write(response, file)
    end
  end

  def write(response, file)
    response.read_body do |segment|
      file.write(segment)
    end
  end

  def get_data(connection, limit)
    connection.request_get(@url.path) do |response|
      case response
      when Net::HTTPSuccess
        write_to_file(response)
      when Net::HTTPRedirection
        fetch_gem(URI.parse(response['location']), limit - 1)
      end
    end
  end

  def fetch_gem(url = nil, limit = 3)
    # XXX: use https by default!
    url ||= @url
    fail ArgumentError, 'HTTP redirect too deep' if limit == 0
    Net::HTTP.start(url.host) do |connection|
      get_data(connection, limit)
    end
    @destination
  end

  def fetch
    if File.exists?(@destination)
      @destination
    else
      fetch_gem
    end
  end
end
