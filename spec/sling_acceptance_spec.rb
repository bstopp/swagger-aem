#!/usr/bin/env ruby
# Load the gem
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'client', 'sling', 'lib'))

require 'apache_sling_api_client'
require 'json'

config = ApacheSling::Configuration.new
config.debugging = false
config.username = 'admin'
config.password = 'admin'
#config.debugging = true
config.host= 'localhost:4502'

api_instance = ApacheSling::DefaultApi.new
api_instance.api_client.config = config

begin
  #Display Content node resource.
  result = api_instance.resource('content')
  puts "Resource Data: #{result}"
rescue ApacheSling::ApiError => e
  puts "Exception when calling DefaultApi->resource: #{e}"
end

