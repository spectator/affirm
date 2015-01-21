require "bundler/gem_tasks"
require "rspec/core/rake_task"

desc "Run specs"
RSpec::Core::RakeTask.new("spec") do |task|
  task.verbose = false
end

desc "Console"
task :console do
  require "irb"
  require "irb/completion"
  require "affirm"
  require "byebug"
  ARGV.clear
  IRB.start
end

task default: :spec
