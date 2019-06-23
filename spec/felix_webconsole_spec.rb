#!/usr/bin/env ruby
# Load the gem

$LOAD_PATH.unshift(
  File.join(File.dirname(__FILE__), '..', 'clients', 'felix', 'webconsole', 'ruby', 'lib')
)
require 'apache_felix_webconsole_client'

describe 'Webconsole API' do

  let(:client_config) do
    config = ApacheFelix::Configuration.new
    config.debugging = false
    config.username = 'admin'
    config.password = 'admin'
    config.debugging = false
    config.host= 'localhost:8080'
    config
  end

  let(:bundle_client) do
    api_instance = ApacheFelix::BundleApi.new
    api_instance.api_client.config = client_config
    api_instance
  end

  describe 'Bundles' do
    it 'should list all bundles' do
      result = bundle_client.list
      expect(result).to_not be(nil)
      expect(result.status).to_not be(nil)
      expect(result.data[0]).to_not be(nil)
    end

    it 'should list details of one bundle' do
      bundle_name = 'org.apache.felix.framework'
      result = bundle_client.info(bundle_name)
      expect(result).to_not be(nil)
      expect(result.status).to_not be(nil)
      expect(result.data[0]).to_not be(nil)
      expect(result.data[0].name).to eq('System Bundle')
      expect(result.data[0].symbolic_name).to eq(bundle_name)
    end

    it 'should support file uploads' do
      bundle_file = File.join(
          File.dirname(__FILE__), 'test-projects', 'core', 'target', 'swagger-aem-testing.core-0.0.1-SNAPSHOT.jar'
      )
      expect(File.exist?(bundle_file)).to be(true)
      bundle = File.new(bundle_file)
      expect { bundle_client.install(bundle, 'install') }.to_not raise_error

      bundle_name = 'com.github.bstopp.swagger.swagger-aem-testing'
      begin
        retries ||= 10
        result = bundle_client.info(bundle_name)
      rescue ApacheFelix::ApiError => e
        will_retry = (retries -= 1) >= 0
        sleep 5
        retry if will_retry
        raise
      end
      expect(result).to_not be(nil)
      expect(result.data[0]).to_not be(nil)
      expect(result.data[0].symbolic_name).to eq(bundle_name)
      expect(result.data[0].state_raw).to eq(2) # Installed
    end

    it 'should support starting a bundle' do
      bundle = 'com.github.bstopp.swagger.swagger-aem-testing'
      result = bundle_client.modify(bundle, 'start')
      expect(result).to_not be(nil)
      expect(result.state_raw).to eq(32) # Active.
    end

    it 'should support stopping a bundle' do
      bundle = 'com.github.bstopp.swagger.swagger-aem-testing'
      result = bundle_client.modify(bundle, 'stop')
      expect(result).to_not be(nil)
      expect(result.state_raw).to eq(4) # Resolved.
    end

    it 'should support refreshing a bundle' do
      bundle = 'com.github.bstopp.swagger.swagger-aem-testing'
      result = bundle_client.modify(bundle, 'refresh')
      expect(result).to_not be(nil)
      expect(result.state_raw).to eq(2) # Installed.
    end

    it 'should support updating a bundle' do
      bundle = 'com.github.bstopp.swagger.swagger-aem-testing'
      result = bundle_client.modify(bundle, 'update')
      expect(result).to_not be(nil)
      expect(result.state_raw).to eq(2) # Installed.
    end

    it 'should support uninstalling a bundle' do
      bundle = 'com.github.bstopp.swagger.swagger-aem-testing'
      result = bundle_client.modify(bundle, 'uninstall')
      expect(result).to_not be(nil)
      expect(result.state_raw).to eq(1) # Uninstalled.
    end

    it 'should support refreshing all bundles' do
      result = bundle_client.refresh_packages('refreshPackages')
      expect(result).to_not be(nil)
      expect(result.status).to_not be(nil)
      expect(result.data[0]).to_not be(nil)
    end
  end

  describe 'ConfigMgr' do

  end
end
