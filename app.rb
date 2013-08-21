# encoding: utf-8

require 'bundler'
Bundler.setup(:defaults)
Bundler.require

require 'sinatra'
require 'sinatra/reloader' if development?

require 'fileutils'
require 'uri'

require './lib/fetcher'

RUBYGEMS_URL = URI.parse('https://rubygems.org')
RUBYGEMS_PORT = 443
CACHE_PATH = "#{Dir.pwd}/cache"
VERSION = '0.0.1'

get '/' do
  "RubyGems proxy cache v#{VERSION}"
end

get '/quick/Marshal.4.8/*' do
  fetch_url = URI.join(RUBYGEMS_URL, request.fullpath)
  destination_file = File.join(CACHE_PATH, request.fullpath)
  gem = Fetcher.new(fetch_url, destination_file)
  gem.fetch

  send_file destination_file
end

get '/gems/*' do
  fetch_url = URI.join(RUBYGEMS_URL, request.fullpath)
  destination_file = File.join(CACHE_PATH, request.fullpath)
  gem = Fetcher.new(fetch_url, destination_file)
  gem.fetch

  send_file destination_file
end

get '/*'do
  redirect_uri = [RUBYGEMS_URL.to_s, request.fullpath].join
  logger.info "Redirecting to: #{redirect_uri}"
  redirect redirect_uri, 303
end
