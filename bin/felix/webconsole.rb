#!/usr/bin/env ruby

require 'json'
require 'git'

project_basedir = File.join(File.dirname(__FILE__), '..', '..')
api = File.basename(__FILE__, '.rb');
api_dir = File.join(project_basedir, 'api', 'felix', api)

files = Dir[File.join(api_dir, '*.json')]

SPEC = "#{project_basedir}/api/felix/webconsole.yaml".freeze
GIT_ROOT = 'git@github.com'.freeze

#SWAGGER_CMD = 'swagger-codegen'.freeze

SWAGGER_CMD = "java -XX:MaxPermSize=256M -Xmx1024M -DloggerPath=conf/log4j.properties -jar #{project_basedir}/bin/swagger-codegen-cli-2.2.1.jar"
OUTPUT_BASE = File.join(project_basedir, 'clients', 'felix', api).freeze

files.each do |file|
  lang = File.basename(file, '.json')
  config = JSON.parse(File.read(file))
  output_dir = File.join(OUTPUT_BASE, lang)

  unless Dir.exist?(output_dir)
    Git.clone(
      "#{GIT_ROOT}:#{config['gitUserId']}/#{config['gitRepoId']}.git",
      lang,
      :path => OUTPUT_BASE
    )
  end

  cmd = "#{SWAGGER_CMD} generate -i #{SPEC} -t templates "
  cmd += "-l #{lang} -c #{file} "
  cmd += "-o #{output_dir}"
  `#{cmd}`
  File.chmod(0755, File.join(output_dir, 'git_push.sh'))
end