require 'bundler'
Bundler.setup(:defaults)
Bundler.require

require 'sinatra'
require 'sinatra/reloader' if development?

require 'fileutils'

require 'uri'
require 'net/https'
require 'pry'

require './lib/fetcher'

RUBYGEMS_URL = URI.parse('https://rubygems.org')
RUBYGEMS_PORT = 443
CACHE_PATH = "#{Dir.pwd}/cache"
VERSION = '0.0.1'

FileUtils.mkdir_p(CACHE_PATH + '/gems')


get '/' do
  "RubyGems proxy cache v#{VERSION}"
end

get '/api/v1/*'do
  redirect_uri = [RUBYGEMS_URL.to_s, request.fullpath].join
  logger.info "Redirecting to: #{redirect_uri}"
  redirect redirect_uri, 303
end

get '/gems/*' do

  fetch_url = URI.join(RUBYGEMS_URL, request.fullpath)
  destination_file = [CACHE_PATH, request.fullpath].join
  gem = Fetcher.new(fetch_url, destination_file)
  gem.fetch

  send_file destination_file
end
