#!/usr/bin/env ruby
# Load the gem
require 'crx_packmgr_api_client'
require 'json'

config = CrxPackageManager::Configuration.new
config.debugging = false
config.username = 'admin'
config.password = 'admin'
#config.host= 'localhost:4503'

api_instance = CrxPackageManager::DefaultApi.new
api_instance.api_client.config = config

begin
  #List all available packages.
  result = api_instance.list(:path => '/etc/packages/Adobe/granite/com.adobe.granite.httpcache.content-1.0.2.zip')
  p result.results[0]
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->list: #{e}"
end