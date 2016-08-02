#!/usr/bin/env rake
Dir.glob('lib/tasks/*.rake').each { |r| load r }

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  puts '>>>>> RSpec gem not loaded, omitting tasks' unless ENV['CI']
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue StandardError => error
  unless ENV['CI']
    puts '>>>>> Kitchen gem not loaded, omitting tasks'
    puts ">>>>> #{error.message}"
  end
end

begin
  require 'foodcritic'
  FoodCritic::Rake::LintTask.new
rescue LoadError
  puts '>>>>> FoodCritic gem not loaded, omitting tasks' unless ENV['CI']
end

desc 'Publish cookbook at Chef Supermarket'
task :share do
  `knife cookbook site share "rvm_sl" "Package Management"`
end

task default: [:foodcritic, :unit]
