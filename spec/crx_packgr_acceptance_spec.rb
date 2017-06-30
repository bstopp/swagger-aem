#!/usr/bin/env ruby
# Load the gem
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'clients', 'crx-packmgr', 'lib'))

require 'crx_packmgr_api_client'
require 'json'
require 'xmlsimple'

config = CrxPackageManager::Configuration.new
config.debugging = false
config.username = 'admin'
config.password = 'admin'
config.timeout = 10
config.debugging = true
config.host= 'localhost:4502'

api_instance = CrxPackageManager::DefaultApi.new
api_instance.api_client.config = config

begin
  # List all available packages.
  result = api_instance.list(:path => '/etc/packages/Adobe/granite/com.adobe.granite.httpcache.content-1.0.2.zip')
  p "Package List: #{result.results[0]}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->list: #{e.message}"
end


begin
  # Download a package
  result = api_instance.download(:path => '/etc/packages/Adobe/granite/com.adobe.granite.httpcache.content-1.0.2.zip')
  p "Download: #{result}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->list: #{e}"
end

begin
  # List all Groups
  result = api_instance.groups
  p "Group: #{result.groups[0]}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->groups: #{e}"
end

begin
  # Display metadata
  result = api_instance.init
  p "Metadata: #{result}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->init: #{e}"
end

begin
  # Display installstatus
  result = api_instance.installstatus
  p "Install Status: #{result}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->installstatus: #{e}"
end

begin
  # Get a Screenshot
  result = api_instance.screenshot(path: '/etc/packages/RedRobin/all-content.zip/jcr:content/vlt:definition/screenshots/462bcbba-057a-4171-9228-1a798646b2a9')
  p "Screenshot: #{result}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->screenshot: #{e}"
end


begin
  # Get a Thumbnail
  result = api_instance.thumbnail(path: '/etc/packages/adobe/consulting/acs-aem-commons-content-3.4.0.zip')
  p "Thumbnail: #{result}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->thumbnail: #{e}"
end

begin
  # Service list help.
  result = api_instance.service_get('help', name: 'test1')
  puts result
  hash = XmlSimple.xml_in(result, ForceArray: false, KeyToSymbol: true)
  response = CrxPackageManager::ServiceResponse.new
  data = response.build_from_hash(hash)
  p "Service Response: #{data.response}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_get: #{e}"
end

begin
  # Upload a package
  package = File.new('/Users/stopp/Downloads/acs-aem-commons-content-3.4.0-min.zip')
  result = api_instance.service_post(
      package,
      name: 'acs-aem-commons-content-test.zip',
      install: true,
      force: false,
      strict: true
  )
  hash = XmlSimple.xml_in(result, ForceArray: false, KeyToSymbol: true, AttrToSymbol: true)
  response = CrxPackageManager::ServiceResponse.new
  data = response.build_from_hash(hash)
  #puts "Service package upload: #{hash[:response][:data][:package][:name]}"
  puts "Service package upload: #{data.response}"
  puts "Service package Status: #{data.response.status[:code]}"
  puts "Service package Status: #{data.response.status[:content]}"

rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_post: #{e}"
end

begin
  # Service Exec build.
  result = api_instance.service_exec('build', 'test', 'my_packages', '2.0.0')
  puts result
  puts "Service Exec Response: #{result.success}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_exec: #{e}"
end

begin
  # Service Exec install.
  result = api_instance.service_exec('install', 'aem-service-pkg', 'adobe/cq620/servicepack', '6.2.SP1')
  puts result
  puts "Service Exec Response: #{result.success}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_exec: #{e}"
end

begin
  # Service Exec dryrun.
  result = api_instance.service_exec('dryrun', 'test', 'my_packages', '2.0.0')
  puts result
  puts "Service Exec Response: #{result.success}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_exec: #{e}"
end

begin
  # Service Exec uninstall.
  result = api_instance.service_exec('uninstall', 'test', 'my_packages', '2.0.0')
  puts result
  puts "Service Exec Response: #{result.success}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_exec: #{e}"
end

begin
  # Service Exec delete.
  result = api_instance.service_exec('delete', 'test', 'my_packages', '2.0.0')
  puts result
  puts "Service Exec Response: #{result.success}"
rescue CrxPackageManager::ApiError => e
  puts "Exception when calling DefaultApi->service_exec: #{e}"
end
