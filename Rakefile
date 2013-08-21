require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


require 'reek/rake/task'

Reek::Rake::Task.new do |t|
  t.fail_on_error = false
end

require 'rubocop/rake_task'

Rubocop::RakeTask.new


require 'fileutils'
namespace 'rubygems_proxy' do
  desc 'clean the cache in ./cache/'
  task :clean do
    FileUtils.rm_rf('cache')
  end
end

desc 'Run all tests and checkers'
task ci:  %w[spec reek rubocop]
