require 'rake'
require "rspec/core/rake_task"

desc 'Default: run RSpec examples'
task :default => :spec

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_path = '/usr/bin/rspec'
end
