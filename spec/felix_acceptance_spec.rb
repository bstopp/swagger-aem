#!/usr/bin/env ruby
# Load the gem
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'clients', 'felix', 'lib'))

require 'apache_felix_api_client'

config = ApacheFelix::Configuration.new
config.debugging = false
config.username = 'admin'
config.password = 'admin'
config.debugging = true
config.host= 'localhost:4502'

api_instance = ApacheFelix::DefaultApi.new
api_instance.api_client.config = config

begin
  # List all available bundles.
  result = api_instance.bundles
  p "Bundle List: #{result.status}"
rescue ApacheFelix::ApiError => e
  puts "Exception when calling DefaultApi->bundles: #{e}"
end

begin
  # List bundle details.
  result = api_instance.bundle_info('org.apache.felix.framework')
  p "Bundle Name: #{result.data[0].name}"
rescue ApacheFelix::ApiError => e
  puts "Exception when calling DefaultApi->bundles: #{e}"
end
